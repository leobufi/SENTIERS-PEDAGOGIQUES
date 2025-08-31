require "net/http"
require "json"

class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
    @general = General.first
  end

  def create
    # Vérif Turnstile avant de traiter le formulaire
    unless verify_turnstile(params["cf-turnstile-response"])
      flash[:error] = "Veuillez valider le captcha avant d'envoyer le formulaire."
      return redirect_to new_contact_path
    end

    @contact = Contact.new(contact_params)
    @contact.request = request

    if @contact.deliver
      flash[:notice] = "Votre message a bien été envoyé. Nous vous répondrons dès que possible."
    else
      flash[:error] = "Désolé nous n'avons pas reçu votre message. Réessayez plus tard ou écrivez directement à contact@sentiers-pedagogiques.com"
    end

    redirect_to new_contact_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :nickname)
  end

  def verify_turnstile(token)
    return false if token.blank?

    uri = URI("https://challenges.cloudflare.com/turnstile/v0/siteverify")
    res = Net::HTTP.post_form(uri, {
      "secret" => ENV["TURNSTILE_SECRET_KEY"],
      "response" => token,
      "remoteip" => request.remote_ip
    })

    json = JSON.parse(res.body)
    json["success"] == true
  rescue => e
    Rails.logger.error "Turnstile error: #{e.message}"
    false
  end
end
