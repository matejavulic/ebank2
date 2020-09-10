import { DashService } from './dashboard.service';
//import { DashboardComponent } from './dashboard.component'
import { 
  HttpClientModule,
  HttpErrorResponse
 } from '@angular/common/http';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';

import { TestBed } from '@angular/core/testing';
import { 
  HttpClientTestingModule,
  HttpTestingController
 } from '@angular/common/http/testing';
import { HttpClient } from '@angular/common/http';

// Spy for testing dateFromISO8601
describe("Spy for testing return value of dateFromISO8601", ()=> {
    let service: DashService;

    beforeEach(() => {
        class RouterStub {
            navigateByUrl(url: string) {
              return url;
            }
          }

        TestBed.configureTestingModule({
            imports: [HttpClientModule],
            providers: [
                DashService,
                {provide: Router, useClass: RouterStub}
            ] 
            });
      });

    it('should return string from ISO8601 2019-01-12T23:00:00.000Z', () => {
        service = TestBed.get(DashService);
        expect(service.dateFromISO8601('2019-01-12T23:00:00.000Z')).toEqual(jasmine.any(String));
      });

    it('should return date 13-01-19 from ISO8601 2019-01-12T23:00:00.000Z', () => {
        service = TestBed.get(DashService);
        expect(service.dateFromISO8601('2019-01-12T23:00:00.000Z')).toBe('13-01-19');
      });
    
    it('should return string Incorrect date format from 13-11', () => {
        service = TestBed.get(DashService);
        expect(service.dateFromISO8601('13-11')).toBe('Incorrect date format');
      });
    
})

// testing of http requests made by getUserData()
describe('HTTP request made by getserData()', ()=>{
  let httpClient: HttpClient;
  let httpTestingController: HttpTestingController;
  let service: DashService;

  beforeEach(() => {
    class RouterStub {
      navigateByUrl(url: string) {
        return url;
      }
    }
    TestBed.configureTestingModule({
      imports: [ HttpClientTestingModule ],
      providers: [
        DashService,
        {provide: Router, useClass: RouterStub}
    ]
    });

    httpClient = TestBed.get(HttpClient);
    httpTestingController = TestBed.get(HttpTestingController);
  });

  it('should be GET', () => {
    const testData = { 
    name:'John',
     surname:'Doe',
     clientNumber:167,
     branch:'BG-Zm',
     balance:1500,
     transactions: {tran:[]},
     exchangeList: [],
     limitMonthly: 15000,
     usedLimit: 0
     };
    let testUrl='http://localhost:3000/api/user/dash/';
    
    service = TestBed.get(DashService);
    // Make an HTTP GET request
    service.getUserData('1');
   
   service.getUserDataListener().subscribe(data =>
        // When observable resolves, result should match test data
        expect(data).toEqual(testData)
      );
  
    // The following `expectOne()` will match the request's URL.
    // If no requests or multiple requests matched that URL
    // `expectOne()` would throw.
    const req = httpTestingController.expectOne('http://localhost:3000/api/user/dash/1');
  
    // Assert that the request is a GET.
    expect(req.request.method).toEqual('GET');
  
    // Respond with mock data, causing Observable to resolve.
    // Subscribe callback asserts that correct data was returned.
    req.flush(testData);
  
    // Finally, assert that there are no outstanding requests.
    httpTestingController.verify();
  });
})

