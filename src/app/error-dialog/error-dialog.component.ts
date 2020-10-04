import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  templateUrl: './error-dialog.component.html',
  styleUrls: ['../styles/distr/css/error-dialog.component.min.css']
})
export class ErrorComponent {
  constructor(@Inject(MAT_DIALOG_DATA) public data: {errorCode: string, message: string}) {}
}
