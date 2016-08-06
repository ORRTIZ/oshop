<#if productStorePaymentMethodTypeIdMap.EXT_PAYPAL??>
    <div>
        <input type="radio" id="checkOutPaymentId_PAYPAL" name="checkOutPaymentId" value="EXT_PAYPAL" <#if "EXT_PAYPAL" == checkOutPaymentId>checked="checked"</#if> />
        <label for="checkOutPaymentId_PAYPAL">${uiLabelMap.AccountingPayWithPayPal}</label>
    </div>
</#if>
