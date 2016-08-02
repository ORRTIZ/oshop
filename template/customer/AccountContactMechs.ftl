<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.PartyContactInformation}</h3>
        <div class="boxlink">
            <a href="<@ofbizUrl>editcontactmech</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.CommonCreateNew}</a>
        </div>
    </div>
    <div class="panel-body">
        <#if partyContactMechValueMaps?has_content>
            <table width="100%" border="0" cellpadding="0">
                <tr valign="bottom">
                    <th>${uiLabelMap.PartyContactType}</th>
                    <th></th>
                    <th>${uiLabelMap.CommonInformation}</th>
                    <th>${uiLabelMap.CommonInformation}</th>
                    <th colspan="2">${uiLabelMap.PartySolicitingOk}?</th>
                    <th></th>
                    <th></th>
                </tr>
                <#list partyContactMechValueMaps as partyContactMechValueMap>
                    <#assign contactMech = partyContactMechValueMap.contactMech! />
                    <#assign contactMechType = partyContactMechValueMap.contactMechType! />
                    <#assign partyContactMech = partyContactMechValueMap.partyContactMech! />
                    <tr><td colspan="7"></td></tr>
                    <tr>
                        <td valign="top">
                            ${contactMechType.get("description",locale)}
                        </td>
                        <td>&nbsp;</td>
                        <td valign="top">
                            <#if contactMech.contactMechTypeId! = "POSTAL_ADDRESS">
                                <#include "AccountCMPostalAddress.ftl" />
                            <#elseif contactMech.contactMechTypeId! = "TELECOM_NUMBER">
                                <#include "AccountCMTelecom.ftl" />
                            <#elseif contactMech.contactMechTypeId! = "EMAIL_ADDRESS">
                                ${contactMech.infoString}
                            <#elseif contactMech.contactMechTypeId! = "WEB_ADDRESS">
                                <#include "AccountCMWebAddress.ftl" />
                            <#else>
                                ${contactMech.infoString!}
                            </#if>
                            <div>(${uiLabelMap.CommonUpdated}:&nbsp;${partyContactMech.fromDate.toString()})</div>
                            <#if partyContactMech.thruDate??><div>${uiLabelMap.CommonDelete}:&nbsp;${partyContactMech.thruDate.toString()}</div></#if>
                        </td>
                        <td>
                            <#list partyContactMechValueMap.partyContactMechPurposes! as partyContactMechPurpose>
                                <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true) />
                                <div>
                                    <#if contactMechPurposeType??>
                                        ${contactMechPurposeType.get("description",locale)}
                                        <#if contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION" && (profiledefs.defaultShipAddr)?default("") == contactMech.contactMechId>
                                            <span class="buttontextdisabled">${uiLabelMap.EcommerceIsDefault}</span>
                                        <#elseif contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION">
                                            <form name="defaultShippingAddressForm" method="post" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>">
                                                <input type="hidden" name="productStoreId" value="${productStoreId}" />
                                                <input type="hidden" name="defaultShipAddr" value="${contactMech.contactMechId}" />
                                                <input type="hidden" name="partyId" value="${party.partyId}" />
                                                <input type="submit" value="${uiLabelMap.EcommerceSetDefault}" class="btn btn-default btn-xs" />
                                            </form>
                                        </#if>
                                    <#else>
                                        ${uiLabelMap.PartyPurposeTypeNotFound}: "${partyContactMechPurpose.contactMechPurposeTypeId}"
                                    </#if>
                                    <#if partyContactMechPurpose.thruDate??>(${uiLabelMap.CommonExpire}:${partyContactMechPurpose.thruDate.toString()})</#if>
                                </div>
                            </#list>
                        </td>
                        <td align="center" valign="top"><div>(${partyContactMech.allowSolicitation!})</div></td>
                        <td>&nbsp;</td>
                        <td align="right" valign="top">
                            <a href="<@ofbizUrl>editcontactmech?contactMechId=${contactMech.contactMechId}</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.CommonUpdate}</a>
                        </td>
                        <td align="right" valign="top">
                            <form name= "deleteContactMech_${contactMech.contactMechId}" method= "post" action= "<@ofbizUrl>deleteContactMech</@ofbizUrl>">
                                <div>
                                    <input type= "hidden" name= "contactMechId" value= "${contactMech.contactMechId}"/>
                                    <a href='javascript:document.deleteContactMech_${contactMech.contactMechId}.submit()' class='btn btn-default btn-xs'>${uiLabelMap.CommonExpire}</a>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                </#list>
            </table>
        <#else>
            <label>${uiLabelMap.PartyNoContactInformation}.</label><br />
        </#if>
    </div>
</div>