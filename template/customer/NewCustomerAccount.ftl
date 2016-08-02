
<fieldset class="col">
    <legend><#if getUsername>${uiLabelMap.CommonUsername}</#if></legend>
    <#if getUsername>
        <@fieldErrors fieldName="USERNAME"/>
        <div class="row">
            <div class="col-md-4">
                <label for="USERNAME">${uiLabelMap.CommonUsername}*</label>
            </div>
            <div class="col-md-8">
                <#if requestParameters.preferredUsername?has_content>
                    <input type="text" name="showUserName" id="showUserName" value="${requestParameters.USERNAME!}" disabled="disabled"/>
                    <input type="hidden" name="USERNAME" id="USERNAME" value="${requestParameters.USERNAME!}"/>
                <#else>
                    <input type="text" name="USERNAME" id="USERNAME" value="${requestParameters.USERNAME!}" onfocus="clickUsername();" onchange="changeEmail();"/>
                </#if>
            </div>
        </#if>
</fieldset>

<fieldset class="col">
    <legend>${uiLabelMap.CommonPassword}</legend>
    <#if createAllowPassword>
        <div class="row">
            <div class="col-md-4">
                <label for="PASSWORD">${uiLabelMap.CommonPassword}*</label>
            </div>
            <div class="col-md-8">
                <@fieldErrors fieldName="PASSWORD"/>
                <input type="password" name="PASSWORD" id="PASSWORD" onfocus="setLastFocused(this);"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <label for="CONFIRM_PASSWORD">${uiLabelMap.PartyRepeatPassword}*</label>
            </div>
            <div class="col-md-8">
                <@fieldErrors fieldName="CONFIRM_PASSWORD"/>
                <input type="password" class='inputBox' name="CONFIRM_PASSWORD" id="CONFIRM_PASSWORD" value="" maxlength="50"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <label for="PASSWORD_HINT">${uiLabelMap.PartyPasswordHint}</label>
            </div>
            <div class="col-md-8">
                <@fieldErrors fieldName="PASSWORD_HINT"/>
                <input type="text" class='inputBox' name="PASSWORD_HINT" id="PASSWORD_HINT" value="${requestParameters.PASSWORD_HINT!}" maxlength="100"/>
            </div>
        </div>
    <#else/>
        <div class="row">
            <div class="col-md-12">
                <label>${uiLabelMap.PartyReceivePasswordByEmail}.</div>
            </div>
        </div>
    </#if>
</fieldset>