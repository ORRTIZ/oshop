<#assign telecomNumber = partyContactMechValueMap.telecomNumber!>
<div>
    <#if telecomNumber??>
        ${telecomNumber.countryCode!}
        <#if telecomNumber.areaCode?has_content>${telecomNumber.areaCode}-</#if>${telecomNumber.contactNumber!}
        <#if partyContactMech.extension?has_content>ext&nbsp;${partyContactMech.extension}</#if>
    <#else>
        ${uiLabelMap.PartyPhoneNumberInfoNotFound}.
    </#if>
</div>