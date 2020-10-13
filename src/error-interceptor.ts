import {
    HttpEvent,
    HttpInterceptor,
    HttpHandler,
    HttpRequest,
    HttpResponse,
    HttpErrorResponse
   } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { ErrorComponent } from './app/error-dialog/error-dialog.component';
import { Observable, throwError } from 'rxjs';
import { retry, catchError } from 'rxjs/operators';
import { Injectable } from '@angular/core';

@Injectable()
   export class ErrorInterceptor implements HttpInterceptor {
    constructor(private dialog: MatDialog) {}
     intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
       return next.handle(request)
       .pipe(
         retry(1), // try one more time if an error occured*/
         catchError((error: HttpErrorResponse) => {
           let errorMessage;
           if (error.error instanceof ErrorEvent) {
             // client-side error
                errorMessage = { message: error.error.message };
             // errorMessage = `Error: ${error.error.message}`;
             // console.log( 'Client side error->' , errorMessage)
            } else {
              // server-side error
              errorMessage = { errorCode: error.status, message: error.error.message };
             // errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
             // console.log( 'Server side error->' , error.error.message);
            }
            // window.alert(errorMessage);
           this.dialog.open(ErrorComponent, {data: errorMessage});
           return throwError(errorMessage);
          })
        );
    }
   }


