<#if productStorePaymentMethodTypeIdMap.EXT_WORLDPAY??>
    <div>
        <input type="radio" id="checkOutPaymentId_WORLDPAY" name="checkOutPaymentId" value="EXT_WORLDPAY" <#if "EXT_WORLDPAY" == checkOutPaymentId>checked="checked"</#if> />
        <label for="checkOutPaymentId_WORLDPAY">${uiLabelMap.AccountingPayWithWorldPay}</label>
    </div>
</#if>