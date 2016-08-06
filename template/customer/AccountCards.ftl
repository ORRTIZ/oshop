
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.AccountingPaymentMethodInformation}</h3>
        <div class="boxlink">
            <a href="<@ofbizUrl>editcreditcard</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.PartyCreateNewCreditCard}</a>
            <a href="<@ofbizUrl>editgiftcard</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.PartyCreateNewGiftCard}</a>
            <a href="<@ofbizUrl>editeftaccount</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.PartyCreateNewEftAccount}</a>
        </div>
    </div>
    <div class="panel-body">
        <table width="100%" border="0" cellpadding="1">
        <tr>
            <td>
                <#if paymentMethodValueMaps?has_content>
                    <table width="100%" cellpadding="2" cellspacing="0" border="0">
                        <#list paymentMethodValueMaps as paymentMethodValueMap>
                            <#assign paymentMethod = paymentMethodValueMap.paymentMethod! />
                            <#assign creditCard = paymentMethodValueMap.creditCard! />
                            <#assign giftCard = paymentMethodValueMap.giftCard! />
                            <#assign eftAccount = paymentMethodValueMap.eftAccount! />
                            <tr>
                                <#if paymentMethod.paymentMethodTypeId! == "CREDIT_CARD">
                                    <td valign="top">
                                        <div>
                                            ${uiLabelMap.AccountingCreditCard}:
                                            <#if creditCard.companyNameOnCard?has_content>${creditCard.companyNameOnCard}&nbsp;</#if>
                                            <#if creditCard.titleOnCard?has_content>${creditCard.titleOnCard}&nbsp;</#if>
                                            ${creditCard.firstNameOnCard}&nbsp;
                                            <#if creditCard.middleNameOnCard?has_content>${creditCard.middleNameOnCard}&nbsp;</#if>
                                            ${creditCard.lastNameOnCard}
                                            <#if creditCard.suffixOnCard?has_content>&nbsp;${creditCard.suffixOnCard}</#if>
                                            &nbsp;${Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)}
                                            <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                                            <#if paymentMethod.fromDate?has_content>(${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()})</#if>
                                            <#if paymentMethod.thruDate??>(${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()})</#if>
                                        </div>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td align="right" valign="top">
                                        <a href="<@ofbizUrl>editcreditcard?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                                            ${uiLabelMap.CommonUpdate}
                                        </a>
                                    </td>
                                <#elseif paymentMethod.paymentMethodTypeId! == "GIFT_CARD">
                                    <#if giftCard?has_content && giftCard.cardNumber?has_content>
                                        <#assign giftCardNumber = "" />
                                        <#assign pcardNumber = giftCard.cardNumber />
                                        <#if pcardNumber?has_content>
                                            <#assign psize = pcardNumber?length - 4 />
                                            <#if (0 < psize)>
                                                <#list 0 .. psize-1 as foo>
                                                    <#assign giftCardNumber = giftCardNumber + "*" />
                                                </#list>
                                                <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3] />
                                        <#else>
                                            <#assign giftCardNumber = pcardNumber />
                                        </#if>
                                    </#if>
                                </#if>

                  <td valign="top">
                    <div>
                      ${uiLabelMap.AccountingGiftCard}: ${giftCardNumber}
                      <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                      <#if paymentMethod.fromDate?has_content>(${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()})</#if>
                      <#if paymentMethod.thruDate??>(${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()})</#if>
                    </div>
                  </td>
                  <td >&nbsp;</td>
                  <td align="right" valign="top">
                    <a href="<@ofbizUrl>editgiftcard?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                            ${uiLabelMap.CommonUpdate}</a>
                  </td>
                  <#elseif paymentMethod.paymentMethodTypeId! == "EFT_ACCOUNT">
                  <td valign="top">
                    <div>
                      ${uiLabelMap.AccountingEFTAccount}: <#if eftAccount.accountNumber?has_content>${eftAccount.accountNumber}</#if>
                      <br/>${eftAccount.nameOnAccount!}
                      <#if eftAccount.bankName?has_content><br/>${uiLabelMap.AccountingBank}: ${eftAccount.bankName}</#if>
                      <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                      <#if paymentMethod.fromDate?has_content><br/>${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()}</#if>
                      <#if paymentMethod.thruDate??><br/>${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()}</#if>
                    </div>
                  </td>
                  <td>&nbsp;</td>
                  <td align="right" valign="top">
                    <a href="<@ofbizUrl>editeftaccount?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                            ${uiLabelMap.CommonUpdate}</a>
                  </td>
                </#if>
                <td align="right" valign="top">
                 <a href="<@ofbizUrl>deletePaymentMethod/viewprofile?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                        ${uiLabelMap.CommonExpire}</a>
                </td>
                <td align="right" valign="top">
                  <#if (profiledefs.defaultPayMeth)?default("") == paymentMethod.paymentMethodId>
                    <span class="buttontextdisabled">${uiLabelMap.EcommerceIsDefault}</span>
                  <#else>
                    <form name="defaultPaymentMethodForm" method="post" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>">
                      <input type="hidden" name="productStoreId" value="${productStoreId}" />
                      <input type="hidden" name="defaultPayMeth" value="${paymentMethod.paymentMethodId}" />
                      <input type="hidden" name="partyId" value="${party.partyId}" />
                      <input type="submit" value="${uiLabelMap.EcommerceSetDefault}" class="button" />
                    </form>
                  </#if>
                </td>
              </tr>
            </#list>
          </table>
          <#else>
            ${uiLabelMap.AccountingNoPaymentMethodInformation}.
          </#if>
        </td>
      </tr>
    </table>
    </div>
</div>
</div>