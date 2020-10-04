import { ErrorInterceptor } from './error-interceptor';
import { throwError } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';

describe('Error interceptor', () => {
  let errorInterceptor;
  let matDialog: MatDialog;
  const error = {statusText: 'error'};

  beforeEach(() => {
    errorInterceptor = new ErrorInterceptor(matDialog);
      });

  it('should catch err response returned from api', () => {
      // arrange
      let httpRequestSpy = jasmine.createSpyObj('HttpRequest', ['notImportant']);
      let httpHandlerSpy = jasmine.createSpyObj('HttpHandler', ['handle']);
      httpHandlerSpy.handle.and.returnValue(throwError({error}));
      // act
      errorInterceptor.intercept(httpRequestSpy, httpHandlerSpy)
          .subscribe(
              result => console.log('Ok', result),
              err => {
                  expect(err).toBeDefined();
              }
          );
  });
});
