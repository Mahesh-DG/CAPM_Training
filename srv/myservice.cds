using { anubhav.db.master } from '../db/datamodel';



// service defination - skeleton of our service end point
service MyService @(path:'MyService') {

function hellocap(name: String(100)) returns String(100);
 @readonly
 entity ReadEmployeeSrv  as projection on master.employees;

}