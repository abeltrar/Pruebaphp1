import { Injectable } from '@angular/core';
import { ResponseI } from '../../modelos/response.interface';
import { ListaProductosI } from '../../modelos/listaproductos.interface';
//import { PacienteI } from '../../modelos//paciente.interface';
import { HttpClient , HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  $heder

  url:string = "http://localhost/AppCafeteria/productos";

  constructor(private http:HttpClient) { }

 
  getAllProductos(page:number):Observable<ListaProductosI[]>{
    let direccion = this.url + "productos?page=" + page;
    return this.http.get<ListaProductosI[]>(direccion);
  }

 /* getSinglePactient(id):Observable<ProductoI>{
    let direccion = this.url + "pacientes?id=" + id;
    return this.http.get<ProductoI>(direccion);
  }

  putPatient(form:ProductoI):Observable<ResponseI>{
    let direccion = this.url + "pacientes";
    return this.http.put<ResponseI>(direccion, form);
  }

  deletePatient(from:ProductoI):Observable<ResponseI>{
    let direccion = this.url + "pacientes";
    let Options = {
      headers: new HttpHeaders({
         'Conten-type': 'application/json'
      }),
      body:from
    }
    return this.http.delete<ResponseI>(direccion, Options);
  }

  postPatient(form:ProductoI):Observable<ResponseI>{
    let direccion = this.url+ "pacientes";
    return this.http.post<ResponseI>(direccion,form);
  }*/


}
