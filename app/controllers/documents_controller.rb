class DocumentsController < ApplicationController
  before_action :set_document, only: %i[destroy toggle_verification]
  before_action :require_admin!, only: %i[toggle_verification]

  def index
    @documents =
      if Current.user&.admin?
        Document.includes(:user, file_attachment: :blob).order(created_at: :desc)
      else
        Current.user.documents.includes(file_attachment: :blob).order(created_at: :desc)
      end
  end

  def new
    @document = Current.user.documents.build
  end

  def create
    @document = Current.user.documents.build(document_params)

    if @document.save
      redirect_to documents_path, notice: "Document uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if Current.user&.admin? || @document.user == Current.user
      @document.destroy
      redirect_to documents_path, notice: "Document deleted."
    else
      redirect_to documents_path, alert: "Not authorized."
    end
  end

  def toggle_verification
    @document.update!(is_verified: !@document.is_verified)

    redirect_back(
      fallback_location: documents_path,
      notice: @document.is_verified? ? "Document verified." : "Document unverified."
    )
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def require_admin!
    redirect_to root_path, alert: "Not authorized." unless Current.user&.admin?
  end

  def document_params
    params.require(:document).permit(:document_type, :notes, :file)
  end
end