const { employees } = cds.entities("anubhav.db.master");
module.exports = function(srv) {

    //srvice Implementation
    srv.on('hellocap', function(req) {
        return "Hello my cap devloper " + req.data.name;
    });

    srv.on('READ', 'ReadEmployeeSrv' , async function(req) {
        var results = [];
        var whereCondition = req.data;
        console.log(whereCondition);
        if(whereCondition.hasOwnProperty("ID")){
            results = await cds.tx(req).run(SELECT.from(employees).limit(10).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(1));
        }
           return results;
    //     return {

    //   "ID": "Random",
    //   "nameFirst": "Paresh",
    //   "nameMiddle": null,
    //   "nameLast": "Thakur",
    //   "nameInitials": null,
    //   "sex": "M",
    //   "language": "E",
    //     }
    });
}