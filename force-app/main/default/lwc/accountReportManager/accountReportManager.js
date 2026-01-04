import { LightningElement, api, track } from 'lwc';
import generatePDF from '@salesforce/apex/AccountReportService.generateAndAttachPDF';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountReportManager extends LightningElement {
    @api recordId;   // will be set if component is on a record page
    @track isLoading = false;

    connectedCallback() {
        // ✅ Fallback: read Account Id from URL param if not passed automatically
        if (!this.recordId) {
            const urlParams = new URLSearchParams(window.location.search);
            this.recordId = urlParams.get('id'); // expects ?id=001XXXXXXXXXXXXXXX
            console.log('RecordId from URL:', this.recordId);
        }

        // ✅ For testing only: hardcode an Account Id if still missing
        if (!this.recordId) {
            this.recordId = '001Ig00000CWgAUIA1'; // replace with a real Account Id
            console.log('Hardcoded RecordId:', this.recordId);
        }
    }

    handleGenerate() {
        this.isLoading = true;

        generatePDF({ accountId: this.recordId })
            .then((contentDocumentId) => {
                // ✅ Use shepherd download route (works in Experience Cloud)
                window.open(
                    `/sfc/servlet.shepherd/document/download/${contentDocumentId}`,
                    '_blank'
                );

                this.isLoading = false;
                this.showToast('Success', 'PDF saved and opened successfully', 'success');
            })
            .catch((error) => {
                this.isLoading = false;
                this.showToast(
                    'Error',
                    error?.body?.message || 'Something went wrong',
                    'error'
                );
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({ title, message, variant })
        );
    }
}
