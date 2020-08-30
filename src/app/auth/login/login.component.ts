/*
 * License: The MIT License (MIT)
 * Author:E-bank IT team
 * Author email: @ebanka-it.com
 * Date: Fri Aug 23 2019
 * Description:
 * Component to control behaviour of
 * login form.
 *
 */

import {Component, OnDestroy, OnInit} from '@angular/core';
import { NgForm } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Subscription } from 'rxjs';

@Component({
  templateUrl: './login.component.html',
  styleUrls: ['../../styles/distr/css/login.component.min.css']
})

export class LoginComponent implements OnInit, OnDestroy {
  isLoading = false;
  isVerified = true;
  verifyEmail = '';
  private authStatusSub: Subscription;
  private verifStatusSub: Subscription;
  constructor(public authService: AuthService) {}

  ngOnInit() {
    this.authStatusSub = this.authService.getAuthStatusListener().subscribe(
      authStatus => {
        this.isLoading = false;
      }
    );
  }

  onLogin(form: NgForm) {
    if (form.invalid) {
      return;
    }
    this.isLoading = true;
    this.authService.login(form.value.email, form.value.password);
    this.verifyEmail = form.value.email;
    this.verifStatusSub = this.authService.getVerificationStatusListener().subscribe(
      verifStatus => {
         this.isVerified = verifStatus;
         if (verifStatus === false) {
          this.isLoading = false;
         }
         this.verifStatusSub.unsubscribe();
       }
     );
  }

  resetIsVerified() {
    this.isVerified = true;
  }
  ngOnDestroy() {
    this.authStatusSub.unsubscribe();
  }
}
