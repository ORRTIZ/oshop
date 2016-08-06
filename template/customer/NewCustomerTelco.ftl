<fieldset>
    <legend>${uiLabelMap.PartyPhoneNumbers}</legend>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_HOME_CONTACT">${uiLabelMap.PartyHomePhone}</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_HOME_CONTACT"/>
            <input type="text" name="CUSTOMER_HOME_CONTACT" value="${requestParameters.CUSTOMER_HOME_CONTACT!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_HOME_ALLOW_SOL">${uiLabelMap.PartyAllowSolicitation}</label>
        </div>
        <div class="col-md-8">
            <select name="CUSTOMER_HOME_ALLOW_SOL">
              <#if (((requestParameters.CUSTOMER_HOME_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
              <#if (((requestParameters.CUSTOMER_HOME_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
              <option></option>
              <option value="Y">${uiLabelMap.CommonY}</option>
              <option value="N">${uiLabelMap.CommonN}</option>
            </select>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_MOBILE_CONTACT">${uiLabelMap.PartyMobilePhone}</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_MOBILE_CONTACT"/>
            <input type="text" name="CUSTOMER_MOBILE_CONTACT" value="${requestParameters.CUSTOMER_MOBILE_CONTACT!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_HOME_ALLOW_SOL">${uiLabelMap.PartyAllowSolicitation}</label>
        </div>
        <div class="col-md-8">
            <select name="CUSTOMER_MOBILE_ALLOW_SOL">
              <#if (((requestParameters.CUSTOMER_MOBILE_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
              <#if (((requestParameters.CUSTOMER_MOBILE_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
              <option></option>
              <option value="Y">${uiLabelMap.CommonY}</option>
              <option value="N">${uiLabelMap.CommonN}</option>
            </select>
        </div>
    </div>
    
</fieldset>
