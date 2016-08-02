<#if paymentMethod.paymentMethodTypeId == "EFT_ACCOUNT">
    <#if productStorePaymentMethodTypeIdMap.EFT_ACCOUNT??>
        <#assign eftAccount = paymentMethod.getRelatedOne("EftAccount", false) />
        <div>
            <input type="radio" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if paymentMethod.paymentMethodId == checkOutPaymentId>checked="checked"</#if> />
            <label for="checkOutPayment_${paymentMethod.paymentMethodId}">${uiLabelMap.AccountingEFTAccount}:${eftAccount.bankName!}: ${eftAccount.accountNumber!}</label>
            <#if paymentMethod.description?has_content><p>(${paymentMethod.description})</p></#if>
            <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EE', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
        </div>
    </#if>
</#if>