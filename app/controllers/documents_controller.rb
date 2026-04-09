class DocumentsController < ApplicationController

    def index
        @documents = Current.user.documents.order(created_at: :desc)
    end

    def new
        @document = Current.user.documents.build
    end

    def create
        @document = Current.user.documents.build(document_params)

        if @document.save
            redirect_to verification_documents_path, notice: "Document uploaded."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @document = Current.user.documents.find(params[:id])
        @document.destroy
        redirect_to verification_documents_path, notice: "Document deleted."
    end

    private

    def document_params
        params.require(:document).permit(:document_type, :notes, :file)
    end


end
