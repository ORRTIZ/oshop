<div class="screenlet">
  <h3>${uiLabelMap.EcommerceFileManager}</h3>
  <div class="screenlet-body">
    <table width="100%" border="0" cellpadding="1">
      <#if partyContent?has_content>
        <#list partyContent as contentRole>
        <#assign content = contentRole.getRelatedOne("Content", false) />
        <#assign contentType = content.getRelatedOne("ContentType", true) />
        <#assign mimeType = content.getRelatedOne("MimeType", true)! />
        <#assign status = content.getRelatedOne("StatusItem", true) />
          <tr>
            <td><a href="<@ofbizUrl>img/${content.contentName!}?imgId=${content.dataResourceId!}</@ofbizUrl>" class="button">${content.contentId}</a></td>
            <td>${content.contentName!}</td>
            <td>${(contentType.get("description",locale))!}</td>
            <td>${(mimeType.description)!}</td>
            <td>${(status.get("description",locale))!}</td>
            <td>${contentRole.fromDate!}</td>
            <td align="right">
              <form name="removeContent_${contentRole.contentId}" method="post" action="removePartyAsset">
                <input name="partyId" type="hidden" value="${userLogin.partyId}"/>
                <input name="contentId" type="hidden" value="${contentRole.contentId}"/>
                <input name="roleTypeId" type="hidden" value="${contentRole.roleTypeId}"/>
              </form>
              <a href="<@ofbizUrl>img/${content.contentName!}?imgId=${content.dataResourceId!}</@ofbizUrl>" class="button">${uiLabelMap.CommonView}</a>
              <a href="javascript:document.removeContent_${contentRole.contentId}.submit();" class="button">${uiLabelMap.CommonRemove}</a>
            </td>
          </tr>
        </#list>
      <#else>
         <tr><td>${uiLabelMap.EcommerceNoFiles}</td></tr>
      </#if>
    </table>
    <div>&nbsp;</div>
    <label>${uiLabelMap.EcommerceUploadNewFile}</label>
    <div>
      <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>uploadPartyContent</@ofbizUrl>">
      <div>
        <input type="hidden" name="partyId" value="${party.partyId}"/>
        <input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        <input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        <input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        <input type="hidden" name="roleTypeId" value="OWNER"/>
        <input type="file" name="uploadedFile" size="50" class="inputBox"/>
        <select name="partyContentTypeId" class="selectBox">
          <option value="">${uiLabelMap.PartySelectPurpose}</option>
          <#list partyContentTypes as partyContentType>
            <option value="${partyContentType.partyContentTypeId}">${partyContentType.get("description", locale)?default(partyContentType.partyContentTypeId)}</option>
          </#list>
        </select>
        <select name="mimeTypeId" class="selectBox">
          <option value="">${uiLabelMap.PartySelectMimeType}</option>
          <#list mimeTypes as mimeType>
            <option value="${mimeType.mimeTypeId}">${mimeType.get("description", locale)?default(mimeType.mimeTypeId)}</option>
          </#list>
        </select>
        <input type="submit" value="${uiLabelMap.CommonUpload}" class="smallSubmit"/>
        </div>
      </form>
    </div>
  </div>
</div>