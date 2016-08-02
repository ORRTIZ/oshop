
<script type="text/javascript">
//<![CDATA[
function submitForm(form, mode, value) {
    if (mode == "DN") {
        // done action; checkout
        form.action="<@ofbizUrl>checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "CS") {
        // continue shopping
        form.action="<@ofbizUrl>updateCheckoutOptions/showcart</@ofbizUrl>";
        form.submit();
    } else if (mode == "NA") {
        // new address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?preContactMechTypeId=POSTAL_ADDRESS&contactMechPurposeTypeId=SHIPPING_LOCATION&DONE_PAGE=checkoutshippingaddress</@ofbizUrl>";
        form.submit();
    } else if (mode == "EA") {
        // edit address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?DONE_PAGE=checkoutshippingaddress&contactMechId="+value+"</@ofbizUrl>";
        form.submit();
    }
}

function toggleBillingAccount(box) {
    var amountName = box.value + "_amount";
    box.checked = true;
    box.form.elements[amountName].disabled = false;

    for (var i = 0; i < box.form.elements[box.name].length; i++) {
        if (!box.form.elements[box.name][i].checked) {
            box.form.elements[box.form.elements[box.name][i].value + "_amount"].disabled = true;
        }
    }
}

//]]>
</script>
<#assign cart = shoppingCart!/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3" class="panel-title">1)&nbsp;${uiLabelMap.OrderWhereShallWeShipIt}</h3>
    </div>
    <div class="panel-body">
        <form method="post" name="checkoutInfoForm" style="margin:0;">
            <fieldset>
                <input type="hidden" name="checkoutpage" value="shippingaddress"/>
                    <table width="100%" border="0" cellpadding="1" cellspacing="0">
                      <tr>
                        <td colspan="2">
                            <a href="<@ofbizUrl>splitship</@ofbizUrl>" class="btn btn-default">${uiLabelMap.OrderSplitShipment}</a>
                            <a href="javascript:submitForm(document.checkoutInfoForm, 'NA', '');" class="btn btn-default">${uiLabelMap.PartyAddNewAddress}</a>
                            <#if (cart.getShipGroupSize() > 1)>
                                <div style="color: red;">${uiLabelMap.OrderNOTEMultipleShipmentsExist}</div>
                            </#if>
                        </td>
                    </tr>
                    <#if shippingContactMechList?has_content>
                        <tr><td colspan="2"><hr /></td></tr>
                        <#list shippingContactMechList as shippingContactMech>
                            <#assign shippingAddress = shippingContactMech.getRelatedOne("PostalAddress", false)>
                            <#assign checkThisAddress = (shippingContactMech_index == 0 && !cart.getShippingContactMechId()?has_content) || (cart.getShippingContactMechId()?default("") == shippingAddress.contactMechId)/>
                            <tr>
                                <td valign="top" width="1%" nowrap="nowrap">
                                    <input type="radio" name="shipping_contact_mech_id" value="${shippingAddress.contactMechId}"<#if checkThisAddress> checked="checked"</#if> /> &nbsp;
                                </td>
                                <td valign="top" width="99%" nowrap="nowrap">
                                    <div>
                                        <#if shippingAddress.toName?has_content><b>${uiLabelMap.CommonTo}:</b>&nbsp;${shippingAddress.toName}<br /></#if>
                                        <#if shippingAddress.attnName?has_content><b>${uiLabelMap.PartyAddrAttnName}:</b>&nbsp;${shippingAddress.attnName}<br /></#if>
                                        <#if shippingAddress.address1?has_content>${shippingAddress.address1}<br /></#if>
                                        <#if shippingAddress.address2?has_content>${shippingAddress.address2}<br /></#if>
                                        <#if shippingAddress.city?has_content>${shippingAddress.city}</#if>
                                        <!--
                                        <#if shippingAddress.stateProvinceGeoId?has_content><br />${shippingAddress.stateProvinceGeoId}</#if>
                                        -->
                                        <#if shippingAddress.postalCode?has_content><br />${shippingAddress.postalCode}</#if>
                                        <#if shippingAddress.countryGeoId?has_content><br />${shippingAddress.countryGeoId}</#if>
                                        <br/>
                                        <a href="javascript:submitForm(document.checkoutInfoForm, 'EA', '${shippingAddress.contactMechId}');" class="btn btn-default">${uiLabelMap.CommonUpdate}</a>
                                        <a href="<@ofbizUrl>splitship</@ofbizUrl>" class="btn btn-default">${uiLabelMap.OrderSplitShipment}</a>
                                        <a href="javascript:submitForm(document.checkoutInfoForm, 'NA', '');" class="btn btn-default">${uiLabelMap.PartyAddNewAddress}</a>
                                        <#if (cart.getShipGroupSize() > 1)>
                                            <div style="color: red;">${uiLabelMap.OrderNOTEMultipleShipmentsExist}</div>
                                        </#if>
                                    </div>
                                </td>
                            </tr>
                            <tr><td colspan="2"><hr /></td></tr>
                        </#list>
                    </#if>
                </table
            </fieldset>
        </form>
        <div class="col-md-6 text-left">
            <a href="javascript:submitForm(document.checkoutInfoForm, 'CS', '');" class="btn btn-warning">${uiLabelMap.OrderBacktoShoppingCart}</a>
        </div>
        <div class="col-md-6 text-right">
            <a href="javascript:submitForm(document.checkoutInfoForm, 'DN', '');" class="btn btn-success">${uiLabelMap.CommonNext}</a>
        </div>
    </div>
</div>