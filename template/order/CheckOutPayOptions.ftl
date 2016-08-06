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


<!-- TODO : Need formatting -->
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
    } else if (mode == "NC") {
        // new credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutpayment</@ofbizUrl>";
        form.submit();
    } else if (mode == "EC") {
        // edit credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "GC") {
        // edit gift card
        form.action="<@ofbizUrl>updateCheckoutOptions/editgiftcard?paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NE") {
        // new eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutpayment</@ofbizUrl>";
        form.submit();
    } else if (mode == "EE") {
        // edit eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    }else if(mode = "EG")
    //edit gift card
        form.action="<@ofbizUrl>updateCheckoutOptions/editgiftcard?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
}
//]]>
$(document).ready(function(){
var issuerId = "";
    if ($('#checkOutPaymentId_IDEAL').attr('checked') == true) {
        $('#issuers').show();
        issuerId = $('#issuer').val();
        $('#issuerId').val(issuerId);
    } else {
        $('#issuers').hide();
        $('#issuerId').val('');
    }
    $('input:radio').click(function(){
        if ($(this).val() == "EXT_IDEAL") {
            $('#issuers').show();
            issuerId = $('#issuer').val();
            $('#issuerId').val(issuerId);
        } else {
            $('#issuers').hide();
            $('#issuerId').val('');
        }
    });
    $('#issuer').change(function(){
        issuerId = $(this).val();
        $('#issuerId').val(issuerId);
    });
});
</script>

 
<#assign cart = shoppingCart! />
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">3)&nbsp;${uiLabelMap.OrderHowShallYouPay}?</h3>
    </div>
    <div class="panel-body">
        <form method="post" id="checkoutInfoForm" action="">
            <fieldset>
                <input type="hidden" name="checkoutpage" value="payment" />
                <input type="hidden" name="BACK_PAGE" value="checkoutoptions" />
                <input type="hidden" name="issuerId" id="issuerId" value="" />
                
                <#-- Payment Method Selection -->
                <div>
                    <label>${uiLabelMap.CommonAdd}:</label>
                    <#include "CheckoutPayCreditCard.ftl" />
                    <#include "CheckoutPayEftAccount.ftl" />
                    <#include "CheckoutPayExtOffline.ftl" />
                    <#include "CheckoutPayExtCod.ftl" />
                    <#include "CheckoutPayExtWorldPay.ftl" />
                    <#include "CheckoutPayExtPayPal.ftl" />
                    <#if !paymentMethodList?has_content>
                        <div>
                            <strong>${uiLabelMap.AccountingNoPaymentMethods}.</strong>
                        </div>
                    <#else>
                        <#list paymentMethodList as paymentMethod>
                            <#include "CheckoutPayMethodGiftCard.ftl" />
                            <#include "CheckoutPayMethodCreditCard.ftl" />
                            <#include "CheckoutPayMethodEftAccount.ftl" />
                        </#list>
                    </#if>
                    <#-- special billing account functionality to allow use w/ a payment method -->
                    <#if productStorePaymentMethodTypeIdMap.EXT_BILLACT??>
                        <#if billingAccountList?has_content>
                            <div>
                                <select name="billingAccountId" id="billingAccountId">
                                    <option value=""></option>
                                    <#list billingAccountList as billingAccount>
                                        <#assign availableAmount = billingAccount.accountBalance>
                                        <#assign accountLimit = billingAccount.accountLimit>
                                        <option value="${billingAccount.billingAccountId}" <#if billingAccount.billingAccountId == selectedBillingAccountId?default("")>selected="selected"</#if>>${billingAccount.description?default("")} [${billingAccount.billingAccountId}] ${uiLabelMap.EcommerceAvailable} <@ofbizCurrency amount=availableAmount isoCode=billingAccount.accountCurrencyUomId/> ${uiLabelMap.EcommerceLimit} <@ofbizCurrency amount=accountLimit isoCode=billingAccount.accountCurrencyUomId/></option>
                                    </#list>
                                </select>
                                <label for="billingAccountId">${uiLabelMap.FormFieldTitle_billingAccountId}</label>
                            </div>
                            <div>
                                <input type="text" size="5" id="billingAccountAmount" name="billingAccountAmount" value="" />
                                <label for="billingAccountAmount">${uiLabelMap.OrderBillUpTo}</label>
                            </div>
                        </#if>
                    </#if>
                    <#-- end of special billing account functionality -->
                    <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??>
                        <div>
                            <input type="checkbox" id="addGiftCard" name="addGiftCard" value="Y" />
                            <input type="hidden" name="singleUseGiftCard" value="Y" />
                            <label for="addGiftCard">${uiLabelMap.AccountingUseGiftCardNotOnFile}</label>
                        </div>
                        <div>
                            <label for="giftCardNumber">${uiLabelMap.AccountingNumber}</label>
                            <input type="text" size="15" class="inputBox" id="giftCardNumber" name="giftCardNumber" value="${(requestParameters.giftCardNumber)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
                        </div>
                    <#if cart.isPinRequiredForGC(delegator)>
                        <div>
                            <label for="giftCardPin">${uiLabelMap.AccountingPIN}</label>
                            <input type="text" size="10" class="inputBox" id="giftCardPin" name="giftCardPin" value="${(requestParameters.giftCardPin)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
                        </div>
                    </#if>
                    <div>
                        <label for="giftCardAmount">${uiLabelMap.AccountingAmount}</label>
                        <input type="text" size="6" class="inputBox" id="giftCardAmount" name="giftCardAmount" value="${(requestParameters.giftCardAmount)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
                    </div>
                </#if>
                <div>
                    <#if productStorePaymentMethodTypeIdMap.CREDIT_CARD??><a href="<@ofbizUrl>setBilling?paymentMethodType=CC&amp;singleUsePayment=Y</@ofbizUrl>" class="button">${uiLabelMap.AccountingSingleUseCreditCard}</a></#if>
                    <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??><a href="<@ofbizUrl>setBilling?paymentMethodType=GC&amp;singleUsePayment=Y</@ofbizUrl>" class="button">${uiLabelMap.AccountingSingleUseGiftCard}</a></#if>
                    <#if productStorePaymentMethodTypeIdMap.EFT_ACCOUNT??><a href="<@ofbizUrl>setBilling?paymentMethodType=EFT&amp;singleUsePayment=Y</@ofbizUrl>" class="button">${uiLabelMap.AccountingSingleUseEFTAccount}</a></#if>
                </div>
                <#-- End Payment Method Selection -->
            </fieldset>
        </form>
        <div class="col-md-6 text-left">
            <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'CS', '');" class="btn btn-warning">${uiLabelMap.OrderBacktoShoppingCart}</a>
        </div>
        <div class="col-md-6 text-right">
            <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'DN', '');" class="btn btn-success">${uiLabelMap.OrderContinueToFinalOrderReview}</a>
        </div>
    </div>
</div>