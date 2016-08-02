<fieldset class="col">
    <legend>${uiLabelMap.PartyShippingAddress}</legend>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_ADDRESS1">${uiLabelMap.PartyAddressLine1}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_ADDRESS1"/>
            <input type="text" name="CUSTOMER_ADDRESS1" id="CUSTOMER_ADDRESS1" value="${requestParameters.CUSTOMER_ADDRESS1!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_ADDRESS2">${uiLabelMap.PartyAddressLine2}</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_ADDRESS2"/>
            <input type="text" name="CUSTOMER_ADDRESS2" id="CUSTOMER_ADDRESS2" value="${requestParameters.CUSTOMER_ADDRESS2!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_CITY">${uiLabelMap.PartyCity}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_CITY"/>
            <input type="text" name="CUSTOMER_CITY" id="CUSTOMER_CITY" value="${requestParameters.CUSTOMER_CITY!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_POSTAL_CODE">${uiLabelMap.PartyZipCode}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_POSTAL_CODE"/>
            <input type="text" name="CUSTOMER_POSTAL_CODE" id="CUSTOMER_POSTAL_CODE" value="${requestParameters.CUSTOMER_POSTAL_CODE!}" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="customerCountry">${uiLabelMap.CommonCountry}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_COUNTRY"/>
            <select name="CUSTOMER_COUNTRY" id="newuserform_countryGeoId">
                ${screens.render("component://common/widget/CommonScreens.xml#countries")}
                <#assign defaultCountryGeoId = Static["org.ofbiz.entity.util.EntityUtilProperties"].getPropertyValue("general", "country.geo.id.default", delegator)>
                <option selected="selected" value="${defaultCountryGeoId}">
                    <#assign countryGeo = delegator.findOne("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId), false)>
                    ${countryGeo.get("geoName",locale)}
                </option>
        </select>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="customerState">${uiLabelMap.PartyState}*</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_STATE"/>
            <select name="CUSTOMER_STATE" id="newuserform_stateProvinceGeoId"></select>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="CUSTOMER_ADDRESS_ALLOW_SOL">${uiLabelMap.PartyAllowAddressSolicitation}</label>
        </div>
        <div class="col-md-8">
            <@fieldErrors fieldName="CUSTOMER_ADDRESS_ALLOW_SOL"/>
            <select name="CUSTOMER_ADDRESS_ALLOW_SOL" id="CUSTOMER_ADDRESS_ALLOW_SOL">
                <#if (((requestParameters.CUSTOMER_ADDRESS_ALLOW_SOL)!"") == "Y")><option value="Y">${uiLabelMap.CommonY}</option></#if>
                <#if (((requestParameters.CUSTOMER_ADDRESS_ALLOW_SOL)!"") == "N")><option value="N">${uiLabelMap.CommonN}</option></#if>
                <option></option>
                <option value="Y">${uiLabelMap.CommonY}</option>
                <option value="N">${uiLabelMap.CommonN}</option>
            </select>
        </div>
    </div>
  </fieldset>