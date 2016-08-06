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