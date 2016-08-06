<#if productStorePaymentMethodTypeIdMap.EXT_COD??>
    <div>
        <input type="radio" id="checkOutPaymentId_COD" name="checkOutPaymentId" value="EXT_COD" <#if "EXT_COD" == checkOutPaymentId>checked="checked"</#if> />
        <label for="checkOutPaymentId_COD">${uiLabelMap.OrderCOD}</label>
    </div>
</#if>