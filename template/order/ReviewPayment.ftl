<div class="panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.AccountingPaymentInformation}</h3>
    </div>
    <div class="panel-body">
        <#if paymentMethods?has_content || paymentMethodType?has_content || billingAccount?has_content>
            <#-- order payment info -->
            <#-- offline payment address infomation :: change this to use Company's address -->
            <#if !paymentMethod?has_content && paymentMethodType?has_content>
                <#if paymentMethodType.paymentMethodTypeId == "EXT_OFFLINE">
                    ${uiLabelMap.AccountingOfflinePayment}
                    <#if orderHeader?has_content && paymentAddress?has_content>
                        ${uiLabelMap.OrderSendPaymentTo}:
                        <#if paymentAddress.toName?has_content>${paymentAddress.toName}</#if>
                        <#if paymentAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${paymentAddress.attnName}</#if>
                            ${paymentAddress.address1}
                            <#if paymentAddress.address2?has_content>${paymentAddress.address2}</#if>
                            <#assign paymentStateGeo = (delegator.findOne("Geo", {"geoId", paymentAddress.stateProvinceGeoId!}, false))! />
                            ${paymentAddress.city}<#if paymentStateGeo?has_content>, ${paymentStateGeo.geoName!}</#if> ${paymentAddress.postalCode!}
                            <#assign paymentCountryGeo = (delegator.findOne("Geo", {"geoId", paymentAddress.countryGeoId!}, false))! />
                            <#if paymentCountryGeo?has_content>${paymentCountryGeo.geoName!}</#if>
                            ${uiLabelMap.EcommerceBeSureToIncludeYourOrderNb}
                        </#if>
                <#else>
                    <#assign outputted = true>
                    ${uiLabelMap.AccountingPaymentVia} ${paymentMethodType.get("description",locale)}
                </#if>
            </#if>
            
            <#if paymentMethods?has_content>
                <#list paymentMethods as paymentMethod>
                    <#if "CREDIT_CARD" == paymentMethod.paymentMethodTypeId>
                        <#assign creditCard = paymentMethod.getRelatedOne("CreditCard", false)>
                        <#assign formattedCardNumber = Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)>
                    <#elseif "GIFT_CARD" == paymentMethod.paymentMethodTypeId>
                        <#assign giftCard = paymentMethod.getRelatedOne("GiftCard", false)>
                    <#elseif "EFT_ACCOUNT" == paymentMethod.paymentMethodTypeId>
                        <#assign eftAccount = paymentMethod.getRelatedOne("EftAccount", false)>
                    </#if>
                    <#-- credit card info -->
                    <#if "CREDIT_CARD" == paymentMethod.paymentMethodTypeId && creditCard?has_content>
                        <#if outputted?default(false)>
                        </#if>
                        <#assign pmBillingAddress = creditCard.getRelatedOne("PostalAddress", false)!>
                        <li>
                            <ul>
                                <li>
                                    ${uiLabelMap.AccountingCreditCard}
                                    <#if creditCard.companyNameOnCard?has_content>${creditCard.companyNameOnCard}</#if>
                                    <#if creditCard.titleOnCard?has_content>${creditCard.titleOnCard}</#if>
                                    ${creditCard.firstNameOnCard}
                                    <#if creditCard.middleNameOnCard?has_content>${creditCard.middleNameOnCard}</#if>
                                    ${creditCard.lastNameOnCard}
                                    <#if creditCard.suffixOnCard?has_content>${creditCard.suffixOnCard}</#if>
                                </li>
                                <li>${formattedCardNumber}</li>
                            </ul>
                        </li>
                    <#-- Gift Card info -->
                    <#elseif "GIFT_CARD" == paymentMethod.paymentMethodTypeId && giftCard?has_content>
                        <#if outputted?default(false)>
                        </#if>
                        <#if giftCard?has_content && giftCard.cardNumber?has_content>
                            <#assign pmBillingAddress = giftCard.getRelatedOne("PostalAddress", false)!>
                            <#assign giftCardNumber = "">
                            <#assign pcardNumber = giftCard.cardNumber>
                            <#if pcardNumber?has_content>
                                <#assign psize = pcardNumber?length - 4>
                                <#if 0 < psize>
                                    <#list 0 .. psize-1 as foo>
                                        <#assign giftCardNumber = giftCardNumber + "*">
                                    </#list>
                                    <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3]>
                                <#else>
                                    <#assign giftCardNumber = pcardNumber>
                                </#if>
                            </#if>
                        </#if>
                    ${uiLabelMap.AccountingGiftCard}
                    ${giftCardNumber}
                    <#-- EFT account info -->
                    <#elseif "EFT_ACCOUNT" == paymentMethod.paymentMethodTypeId && eftAccount?has_content>
                        <#if outputted?default(false)>
                        </#if>
                        <#assign pmBillingAddress = eftAccount.getRelatedOne("PostalAddress", false)!>
                        ${uiLabelMap.AccountingEFTAccount}
                        ${eftAccount.nameOnAccount!}
                        <#if eftAccount.companyNameOnAccount?has_content>${eftAccount.companyNameOnAccount}</#if>
                        ${uiLabelMap.AccountingBank}: ${eftAccount.bankName}, ${eftAccount.routingNumber}
                        ${uiLabelMap.AccountingAccount} #: ${eftAccount.accountNumber}
                    </#if>
                    <#if pmBillingAddress?has_content>
                        <#if pmBillingAddress.toName?has_content>${uiLabelMap.CommonTo}: ${pmBillingAddress.toName}</#if>
                        <#if pmBillingAddress.attnName?has_content>${uiLabelMap.CommonAttn}: ${pmBillingAddress.attnName}</#if>
                        <#if pmBillingAddress.address2?has_content>${pmBillingAddress.address2}</#if>
                        <#assign pmBillingStateGeo = (delegator.findOne("Geo", {"geoId", pmBillingAddress.stateProvinceGeoId!}, false))! />
                        ${pmBillingAddress.city}<#if pmBillingStateGeo?has_content>, ${ pmBillingStateGeo.geoName!}</#if> ${pmBillingAddress.postalCode!}
                        <#assign pmBillingCountryGeo = (delegator.findOne("Geo", {"geoId", pmBillingAddress.countryGeoId!}, false))! />
                        <#if pmBillingCountryGeo?has_content>${pmBillingCountryGeo.geoName!}</#if>
                    </#if>
                    <#assign outputted = true>
                </#list>
            </#if>
            <#-- billing account info -->
            <#if billingAccount?has_content>
                <#if outputted?default(false)>
            </#if>
            <#assign outputted = true>
            ${uiLabelMap.AccountingBillingAccount}
            #${billingAccount.billingAccountId!} - ${billingAccount.description!}
            </#if>
            <#if (customerPoNumberSet?has_content)>
                ${uiLabelMap.OrderPurchaseOrderNumber}
                <#list customerPoNumberSet as customerPoNumber>
                    ${customerPoNumber!}
                </#list>
            </#if>
        </#if>
    </div>
</div>