<#if paymentMethod.paymentMethodTypeId == "GIFT_CARD">
    <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??>
        <#assign giftCard = paymentMethod.getRelatedOne("GiftCard", false) />
        <#if giftCard?has_content && giftCard.cardNumber?has_content>
            <#assign giftCardNumber = "" />
            <#assign pcardNumber = giftCard.cardNumber />
            <#if pcardNumber?has_content>
                <#assign psize = pcardNumber?length - 4 />
                <#if 0 &lt; psize>
                    <#list 0 .. psize-1 as foo>
                        <#assign giftCardNumber = giftCardNumber + "*" />
                    </#list>
                    <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3] />
                <#else>
                    <#assign giftCardNumber = pcardNumber />
                </#if>
            </#if>
        </#if>
        <div>
            <input type="checkbox" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if cart.isPaymentSelected(paymentMethod.paymentMethodId)>checked="checked"</#if> />
            <label for="checkOutPayment_${paymentMethod.paymentMethodId}">${uiLabelMap.AccountingGift}:${giftCardNumber}</label>
            <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
            <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EG', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
            <strong>${uiLabelMap.OrderBillUpTo}:</strong> <input type="text" size="5" class="inputBox" name="amount_${paymentMethod.paymentMethodId}" value="<#if (cart.getPaymentAmount(paymentMethod.paymentMethodId)?default(0) > 0)>${cart.getPaymentAmount(paymentMethod.paymentMethodId)?string("##0.00")}</#if>" />
        </div>
    </#if>
</#if>