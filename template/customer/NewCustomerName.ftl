<fieldset class="col">
    <legend>${uiLabelMap.PartyFullName}</legend>
    <div class="row">
        <div class="col-md-4">
            <label for="USER_TITLE">${uiLabelMap.CommonTitle}</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="USER_TITLE"/>
            <select name="USER_TITLE" id="USER_TITLE">
                <#if requestParameters.USER_TITLE?has_content >
                    <option>${requestParameters.USER_TITLE}</option>
                    <option value="${requestParameters.USER_TITLE}"> -- </option>
                <#else>
                    <option value="">${uiLabelMap.CommonSelectOne}</option>
                </#if>
                <option>${uiLabelMap.CommonTitleMr}</option>
                <option>${uiLabelMap.CommonTitleMrs}</option>
                <option>${uiLabelMap.CommonTitleMs}</option>
                <option>${uiLabelMap.CommonTitleDr}</option>
            </select>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="USER_FIRST_NAME">${uiLabelMap.PartyFirstName}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="USER_FIRST_NAME"/>
            <input type="text" name="USER_FIRST_NAME" id="USER_FIRST_NAME" value="${requestParameters.USER_FIRST_NAME!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="USER_LAST_NAME">${uiLabelMap.PartyLastName}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="USER_LAST_NAME"/>
            <input type="text" name="USER_LAST_NAME" id="USER_LAST_NAME" value="${requestParameters.USER_LAST_NAME!}" />
        </div>
    </div>
</fieldset>