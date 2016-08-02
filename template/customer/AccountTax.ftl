<div class="screenlet">
  <h3>${uiLabelMap.PartyTaxIdentification}</h3>
  <div class="screenlet-body">
    <form method="post" action="<@ofbizUrl>createCustomerTaxAuthInfo</@ofbizUrl>" name="createCustTaxAuthInfoForm">
      <div>
      <input type="hidden" name="partyId" value="${party.partyId}"/>
      ${screens.render("component://order/widget/ordermgr/OrderEntryOrderScreens.xml#customertaxinfo")}
      <input type="submit" value="${uiLabelMap.CommonAdd}" class="smallSubmit"/>
      </div>
    </form>
  </div>
</div>
