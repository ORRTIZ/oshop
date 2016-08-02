<#if paymentMethod.paymentMethodTypeId == "CREDIT_CARD">
    <#if productStorePaymentMethodTypeIdMap.CREDIT_CARD??>
        <#assign creditCard = paymentMethod.getRelatedOne("CreditCard", false) />
        <div>
            <input type="checkbox" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if cart.isPaymentSelected(paymentMethod.paymentMethodId)>checked="checked"</#if> />
            <label for="checkOutPayment_${paymentMethod.paymentMethodId}">CC:${Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)}</label>
            <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
            <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EC', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
            <label for="amount_${paymentMethod.paymentMethodId}"><strong>${uiLabelMap.OrderBillUpTo}:</strong></label><input type="text" size="5" class="inputBox" id="amount_${paymentMethod.paymentMethodId}" name="amount_${paymentMethod.paymentMethodId}" value="<#if (cart.getPaymentAmount(paymentMethod.paymentMethodId)?default(0) > 0)>${cart.getPaymentAmount(paymentMethod.paymentMethodId)?string("##0.00")}</#if>" />
        </div>
    </#if>
</#if>