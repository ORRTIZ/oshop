<form name="setdefaultshipmeth" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>" method="post">
<div>
  <input type="hidden" name="productStoreId" value="${productStoreId}" />
  <div class="screenlet">
    <div class="boxlink">
      <#if profiledefs?has_content && profiledefs.defaultShipAddr?has_content && carrierShipMethods?has_content><a href="javascript:document.setdefaultshipmeth.submit();" class="submenutextright">${uiLabelMap.EcommerceSetDefault}</a></#if>
    </div>
    <h3>${uiLabelMap.EcommerceDefaultShipmentMethod}</h3>
    <div class="screenlet-body">
      <table width="100%" border="0" cellpadding="1">
        <#if profiledefs?has_content && profiledefs.defaultShipAddr?has_content && carrierShipMethods?has_content>
          <#list carrierShipMethods as shipMeth>
            <#assign shippingMethod = shipMeth.shipmentMethodTypeId + "@" + shipMeth.partyId />
            <tr>
              <td>&nbsp;</td>
              <td>
                <div><span style="white-space:;"><#if shipMeth.partyId != "_NA_">${shipMeth.partyId!}&nbsp;</#if>${shipMeth.get("description",locale)!}</span></div>
              </td>
              <td><input type="radio" name="defaultShipMeth" value="${shippingMethod}" <#if profiledefs.defaultShipMeth?default("") == shippingMethod>checked="checked"</#if> /></td>
            </tr>
          </#list>
        <#else>
        <tr><td>${uiLabelMap.EcommerceDefaultShipmentMethodMsg}</td></tr>
        </#if>
      </table>
    </div>
  </div>
</div>
</form>