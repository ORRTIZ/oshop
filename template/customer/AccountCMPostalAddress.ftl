<#assign postalAddress = partyContactMechValueMap.postalAddress! />
    <#if postalAddress??>
        <#if postalAddress.toName?has_content>${uiLabelMap.CommonTo}: ${postalAddress.toName}<br /></#if>
        <#if postalAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${postalAddress.attnName}<br /></#if>
        ${postalAddress.address1}<br />
        <#if postalAddress.address2?has_content>${postalAddress.address2}<br /></#if>
        ${postalAddress.city}<#if postalAddress.stateProvinceGeoId?has_content>,&nbsp;${postalAddress.stateProvinceGeoId}</#if>&nbsp;${postalAddress.postalCode!}
        <#if postalAddress.countryGeoId?has_content><br />${postalAddress.countryGeoId}</#if>
        <#if (!postalAddress.countryGeoId?has_content || postalAddress.countryGeoId! = "USA")>
            <#assign addr1 = postalAddress.address1! />
            <#if (addr1.indexOf(" ") > 0)>
                <#assign addressNum = addr1.substring(0, addr1.indexOf(" ")) />
                <#assign addressOther = addr1.substring(addr1.indexOf(" ")+1) />
                <a target="_blank" href="${uiLabelMap.CommonLookupWhitepagesAddressLink}" class="linktext">(${uiLabelMap.CommonLookupWhitepages})</a>
            </#if>
        </#if>
    <#else>
        ${uiLabelMap.PartyPostalInformationNotFound}.
    </#if>