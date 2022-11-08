import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../servicios/api/api.service'
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor(private api:ApiService) { }

  ngOnInit(): void {
    this.api.getAllProductos(1).subscribe(data=>{
      console.log(data)
    })
  }

}
