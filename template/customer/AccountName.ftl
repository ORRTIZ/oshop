
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.PartyPersonalInformation}</h3>
        <div class="boxlink">
            <a href="<@ofbizUrl>editperson</@ofbizUrl>" class="btn btn-default btn-xs">
            <#if person??>${uiLabelMap.CommonUpdate}<#else>${uiLabelMap.CommonCreate}</#if>
            </a>
        </div>
    </div>
    <div class="panel-body">
        <#if person??>
            <table width="50%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="25%">${uiLabelMap.CommonId}</td><td><b>${partyId!}</b></td>
                </tr>
                <tr>
                    <td width="25%">${uiLabelMap.PartyFirstName}</td><td><b>${person.firstName!}</b></td>
                </tr>
                <tr>
                    <td>${uiLabelMap.PartyMiddleName}</td><td><b>${person.middleName!}</b></td>
                </tr>
                <tr>
                    <td>${uiLabelMap.PartyLastName}</td>
                    <td><b>${person.lastName!}</b></td>
                    <td>
                        ${person.personalTitle!}
                        ${person.suffix!}
                    </td>
                </tr>
                <#if person.nickname?has_content>
                    <tr><td>${uiLabelMap.PartyNickName}</td><td>${person.nickname}</td></tr>
                </#if>
                <#if person.gender?has_content>
                    <tr><td align="right">${uiLabelMap.PartyGender}</td><td>${person.gender}</td></tr>
                </#if>
                <#if person.birthDate??>
                    <tr><td align="right">${uiLabelMap.PartyBirthDate}</td><td>${person.birthDate.toString()}</td></tr>
                </#if>
                <#if person.height??>
                    <tr><td align="right">${uiLabelMap.PartyHeight}</td><td>${person.height}</td></tr>
                </#if>
                <#if person.weight??>
                    <tr><td align="right">${uiLabelMap.PartyWeight}</td><td>${person.weight}</td></tr>
                </#if>
                <#if person.mothersMaidenName?has_content>
                    <tr><td align="right">${uiLabelMap.PartyMaidenName}</td><td>${person.mothersMaidenName}</td></tr>
                </#if>
                <#if person.maritalStatus?has_content>
                    <tr><td align="right">${uiLabelMap.PartyMaritalStatus}</td><td>${person.maritalStatus}</td></tr>
                </#if>
                <#if person.socialSecurityNumber?has_content>
                    <tr><td align="right">${uiLabelMap.PartySocialSecurityNumber}</td><td>${person.socialSecurityNumber}</td></tr>
                </#if>
                <#if person.passportNumber?has_content>
                    <tr><td align="right">${uiLabelMap.PartyPassportNumber}</td><td>${person.passportNumber}</td></tr>
                </#if>
                <#if person.passportExpireDate??>
                    <tr><td align="right">${uiLabelMap.PartyPassportExpireDate}</td><td>${person.passportExpireDate.toString()}</td></tr>
                </#if>
                <#if person.totalYearsWorkExperience??>
                    <tr><td align="right">${uiLabelMap.PartyYearsWork}</td><td>${person.totalYearsWorkExperience}</td></tr>
                </#if>
                <#if person.comments?has_content>
                    <tr><td align="right">${uiLabelMap.CommonComments}</td><td>${person.comments}</td></tr>
                </#if>
            </table>
        <#else>
            <label>${uiLabelMap.PartyPersonalInformationNotFound}</label>
        </#if>
    </div>
</div>
