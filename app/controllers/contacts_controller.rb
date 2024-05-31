class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
    @general = General.first
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Votre message a bien été envoyé. Nous vous répondrons dès que possible.'
    else
      flash[:error] = 'Désolé nous n\'avons pas reçu votre message. Réessayez plus tard ou écrivez directement à contact@sentiers-pedagogiques.com'
    end
    redirect_to new_contact_path
  end
end
