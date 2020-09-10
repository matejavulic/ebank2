import { ErrorInterceptor } from './error-interceptor';
import { of, throwError, defer } from "rxjs";

let errorInterceptor;
let authenticationServiceSpy;

beforeEach(() => {
    authenticationServiceSpy = jasmine.createSpyObj('AuthenticationService', ['logout']);
    errorInterceptor = new ErrorInterceptor(authenticationServiceSpy);
})

describe('Error interceptor', () => {
  let httpRequestSpy;
  let httpHandlerSpy;
  const error = {status: 401, statusText: 'error'};

  it('should show status nnn response returned from api', () => {
      //arrange
      httpRequestSpy = jasmine.createSpyObj('HttpRequest', ['doesNotMatter']);
      httpHandlerSpy = jasmine.createSpyObj('HttpHandler', ['handle']);
      httpHandlerSpy.handle.and.returnValue(throwError(
          {error: 
              {message: 'test-error'}
          }
      ));
      //act
      errorInterceptor.intercept(httpRequestSpy, httpHandlerSpy)
          .subscribe(
              result => console.log('good', result), 
              err => { 
                  console.log('error', err);
                  expect(err).toEqual('test-error');
              }
          );

      //assert
      //TBD

      // function fakeAsyncResponseWithError<T>(data: T) {
      //     return defer(() => throwError(error));
      // }
  })
});