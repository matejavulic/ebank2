import {Component} from '@angular/core'; // uvozimo graditelja komponenata
import { NgForm } from '@angular/forms';

@Component({ // ovim dekoratorom pravimo od ove datoteke komponentu
  templateUrl: './help.component.html', // povezujemo html as komponentom (sada html zna gde da trazi promenljive)
  styleUrls: ['../styles/distr/css/help.component.min.css'],
  selector: 'app-help'
})

export class HelpComponent { // komponenta je spolja vidljiva kao LoginComponent
  isLoading = false;
}
