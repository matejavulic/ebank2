/*
 * License: The MIT License (MIT)
 * Author:E-bank IT team
 * Author email: @ebanka-it.com
 * Date: Fri Aug 23 2019
 * Description:
 * Signup component logic. Controlls behaviour
 * of signup form.
 *
 */
import {Component, OnDestroy, OnInit, ElementRef} from '@angular/core';
import { NgForm } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';

@Component({
  templateUrl: './signup.component.html',
  styleUrls: ['../../styles/distr/css/signup.component.min.css']
})

export class SignupComponent implements OnInit, OnDestroy {
  isLoading = false;
  verifyMessage = false;
  resendMessage = false;
  verifyEmail = '';
  userName = '';
  private authStatusSub: Subscription;
  private verifStatusSub: Subscription;
  private resendStatusSub: Subscription;
  constructor(public authService: AuthService, private router: Router, private el: ElementRef) {}

  ngOnInit() {
    setTimeout(() => { // this will make the execution after the above boolean has changed
      this.el.nativeElement.querySelector('#name').focus();
    }, 0);

    this.authStatusSub = this.authService.getAuthStatusListener().subscribe(
      authStatus => {
        this.isLoading = false;
      }
    );
  }

  onSignup(form: NgForm) {
    if (form.invalid) {
      return;
    }
    this.isLoading = true;
    this.verifyEmail = form.value.email;
    this.userName = form.value.name;
    this.authService.createUser(// saljemo zahtev za slanje pod. za novog korisnika
      form.value.email,
      form.value.password,
      form.value.name,
      form.value.surname);
    this.verifStatusSub = this.authService.getVerificationStatusListener().subscribe(
        verifStatus => {
          this.verifyMessage = true;
          this.isLoading = false;
          this.verifStatusSub.unsubscribe();
        });
  }
onResendVerifMail(email: string, userName: string) {
  this.authService.resendVerifMail(email, userName);
  this.resendStatusSub = this.authService.getResendStatusListener().subscribe(
        resendStatus => {
          this.resendMessage = true;
          this.isLoading = false;
          this.resendStatusSub.unsubscribe();
        });
}
  goToLogin() {
    this.router.navigate(['/login']);
  }

  resetForm(form: NgForm) {
    form.reset();
  }

  ngOnDestroy() {
    this.authStatusSub.unsubscribe();
  }
}
