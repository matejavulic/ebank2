import { Component, OnInit, OnDestroy } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { Subscription } from 'rxjs';
import { DashService } from '../dashboard-component/dashboard.service';

@Component({
  selector: 'app-side-menu',
  templateUrl: './side-menu.component.html',
  styleUrls: ['./side-menu.component.css']
})
export class SideMenuComponent implements OnInit, OnDestroy {
  isLoading = false;
  userIsAuthenticated = false;
  selectedMenuItem = 'dashboard';
  private authStatusSub: Subscription;
  private userSub: Subscription; // subscriber to cath asynchronous response from dashboard.service.ts
  user = {
    name: "",
    surname: "",
  };

 /**
  * Here we inject two services:
  * 1. authService - to check if user is authenticated
  * 2. dashService - If an user is authenticated, we load its full name from dashService
  *
  */
 constructor(private authService: AuthService, public dashService: DashService) { }

 ngOnInit() {
   this.isLoading = true;
   const userId = this.authService.getUserId();
   this.dashService.getUserData(userId);
   this.userSub = this.dashService.getUserDataListener()
     .subscribe((userData: { name: string, surname: string}) => {
       this.isLoading = false;
       this.user = userData;
     });
   this.userIsAuthenticated = this.authService.getIsAuth();
   this.authStatusSub = this.authService
     .getAuthStatusListener()
     .subscribe(isAuthenticated => {
       this.userIsAuthenticated = isAuthenticated;
     });
   this.selectComponent('dashboard', 'dashboardHtml');
 }
 ngOnDestroy() {
   this.authStatusSub.unsubscribe();
   this.userSub.unsubscribe();
 }


 onLogout() {
   this.authService.logout();
 }
 changeSelectedItemColor(element: string) {
    // Deselect all buttons in side-menu
    let resetElements = document.getElementsByTagName('a') as HTMLCollectionOf<HTMLElement>;
    // tslint:disable-next-line: prefer-for-of
    for (let i = 0; i < resetElements.length; i++) {
    resetElements[i].style.background = 'white';
    resetElements[i].style.color = 'maroon';
    resetElements[i].style.fontWeight = 'normal';
    }
    // Select the one user wants
    let selectedElement = document.getElementById(element);
    selectedElement.style.background = 'brown';
    selectedElement.style.color = 'white';
    selectedElement.style.fontWeight = '500';
 }
 selectComponent(component: string, element: string) {
  this.changeSelectedItemColor(element);
  switch (component) {
    case 'dashboard':
      this.selectedMenuItem = 'dashboard';
      break;
    case 'accounts':
      this.selectedMenuItem = 'accounts';
      break;
    case 'cards':
      this.selectedMenuItem = 'test';
      break;
    case 'loans':
      this.selectedMenuItem = 'test';
      break;
    case 'aboutUs':
      this.selectedMenuItem = 'postsList';
      break;
    case 'utilities':
      this.selectedMenuItem = 'test';
      break;
    default:
      this.selectedMenuItem = 'dashboard';
      break;
  }
 }
}
