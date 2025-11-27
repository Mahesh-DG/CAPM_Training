sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"dgi/app/managepurchaseorder/test/integration/pages/POsList",
	"dgi/app/managepurchaseorder/test/integration/pages/POsObjectPage",
	"dgi/app/managepurchaseorder/test/integration/pages/PurchaseOrderItemsObjectPage"
], function (JourneyRunner, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('dgi/app/managepurchaseorder') + '/test/flp.html#app-preview',
        pages: {
			onThePOsList: POsList,
			onThePOsObjectPage: POsObjectPage,
			onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

