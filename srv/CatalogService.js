module.exports = cds.service.impl(async function(){
    //get the reference of our entity so later we can perfrom opertions on db
   const { POs, EmployeeSet } = this.entities;
      this.on('boost', async (req,res) => {
        try {
            //here we get a PO ID which is NODE_KEY as input
            const ID = req.params[0];
            //console log for developer understanding
            console.log("Hey Amigo, Your purchase order with id " + req.params[0].NODE_KEY + " will be boosted");
            //CDS query language provided by SAP, we never direct SQL - DB agnostic
            //getting the sap cds tx libray class object to initiate DB tranaction
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 },
                NOTE: 'Boosted!!'
            }).where(ID);
            //send response
            return ID;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
     //adding pre-checks using genric handler
    this.before('CREATE', EmployeeSet, async(req,res) => {
       // check the data which has come for insert
       var payload = req.data;
       // if emp salary tying to save over the 1000000
        if(payload.salaryAmount > 1000000){
        // throw error 
         req.error(500,"OMG! salary over the 1mn not allowed!");     
        }
       
    });

    this.on('getOrderDefaults', async( req, res) => {
          return {OVERALL_STATUS: 'N'};
    });

   //Implementation [service.js]
    this.on('setOrderProcessing', POs, async req => {
        const tx = cds.tx(req);
        await tx.update(POs, req.params[0].ID).set({OVERALL_STATUS: 'A'});
    });


    this.on('getLargestOrder', async ( req, res)=> {
       try {
            const tx = cds.tx(req);
            
            //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;
        } catch (error) {
            return "Error " + error.toString();
        }
    });

});