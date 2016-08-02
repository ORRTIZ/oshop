
<fieldset class="col">
    <legend>${uiLabelMap.PartyEmailAddress}</legend>
    <div class="row">
        <div class="col-md-4">
            <label for= "CUSTOMER_EMAIL">${uiLabelMap.PartyEmailAddress}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_EMAIL"/>
            <input type="text" name="CUSTOMER_EMAIL" id="CUSTOMER_EMAIL" value="${requestParameters.CUSTOMER_EMAIL!}" onchange="changeEmail()" onkeyup="changeEmail()" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_EMAIL_ALLOW_SOL">${uiLabelMap.PartyAllowSolicitation}</label>
        </div>
        <div class="col-md-8">
            <select name="CUSTOMER_EMAIL_ALLOW_SOL" id="CUSTOMER_EMAIL_ALLOW_SOL">
                <#if (((requestParameters.CUSTOMER_EMAIL_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.CUSTOMER_EMAIL_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
            </select>
        </div>
    </div>
  </fieldset>