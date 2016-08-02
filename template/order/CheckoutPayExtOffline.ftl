<#if productStorePaymentMethodTypeIdMap.EXT_OFFLINE??>
    <div>
        <input type="radio" id="checkOutPaymentId_OFFLINE" name="checkOutPaymentId" value="EXT_OFFLINE" <#if "EXT_OFFLINE" == checkOutPaymentId>checked="checked"</#if> />
        <label for="checkOutPaymentId_OFFLINE">${uiLabelMap.OrderMoneyOrder}</label>
    </div>
</#if>