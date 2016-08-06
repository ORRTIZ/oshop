<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<script language="javascript" type="text/javascript">
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
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?preContactMechTypeId=POSTAL_ADDRESS&contactMechPurposeTypeId=SHIPPING_LOCATION&DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EA") {
        // edit address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?DONE_PAGE=checkoutshippingaddress&contactMechId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NC") {
        // new credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EC") {
        // edit credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutoptions&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NE") {
        // new eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EE") {
        // edit eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutoptions&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    }
}

//]]>
</script>

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">2)&nbsp;${uiLabelMap.OrderHowShallWeShipIt}</h3>
    </div>
    <div class="panel-body" style="height: 100%;">
        <form method="post" name="checkoutInfoForm" style="margin:0;">
            <input type="hidden" name="checkoutpage" value="shippingoptions"/>
                <fieldset>
                    <div class="row">
                        <div class="col-md-6">
                            <table width="100%" cellpadding="1" border="0" cellpadding="0" cellspacing="0">
                                <#list carrierShipmentMethodList as carrierShipmentMethod>
                                    <#assign shippingMethod = carrierShipmentMethod.shipmentMethodTypeId + "@" + carrierShipmentMethod.partyId>
                                    <tr>
                                        <td width="1%" valign="top" >
                                            <input type="radio" name="shipping_method" value="${shippingMethod}" <#if shippingMethod == StringUtil.wrapString(chosenShippingMethod!"N@A")>checked="checked"</#if> />&nbsp;
                                        </td>
                                        <td valign="top">
                                            <div>&nbsp;
                                                <#if shoppingCart.getShippingContactMechId()??>
                                                    <#assign shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod)?default(-1)>
                                                </#if>
                                                <#if carrierShipmentMethod.partyId != "_NA_">${carrierShipmentMethod.partyId!}&nbsp;</#if>${carrierShipmentMethod.description!}
                                                <#if shippingEst?has_content> - <#if (shippingEst > -1)><@ofbizCurrency amount=shippingEst isoCode=shoppingCart.getCurrency()/><#else>${uiLabelMap.OrderCalculatedOffline}</#if></#if>
                                            </div>
                                        </td>
                                    </tr>
                                </#list>
                                <#if !carrierShipmentMethodList?? || carrierShipmentMethodList?size == 0>
                                    <tr>
                                        <td width="1%" valign="top">
                                            <input type="radio" name="shipping_method" value="Default" checked="checked" />
                                        </td>
                                        <td valign="top">
                                            <div>${uiLabelMap.OrderUseDefault}.</div>
                                        </td>
                                    </tr>
                                </#if>
                            </table>
                        </div>
                        <div class="col-md-6">
                        <#include "ShippingOptionAllAtOnce.ftl" />
                        <#include "ShippingOptionSpecInstruction.ftl"/>
                        <tr><td colspan="2"><hr /></td></tr>
                        <#include "ShippingOptionPONumber.ftl"/>
                        <#if productStore.showCheckoutGiftOptions! != "N">
                            <#include "ShippingOptionGift.ftl"/>
                        <#else/>
                            <input type="hidden" name="is_gift" value="false"/>
                        </#if>
                        <#include "ShippingOptionAddEmail.ftl"/>
                    </div>
                </div>
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