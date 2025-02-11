<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <#--  ${msg("loginAccountTitle")}  -->
    <#elseif section = "form">

    <header class="header-logo">
        <img src="${url.resourcesPath}/img/logo.svg" alt="logo" />
    </header>

    <div id="kc-form" class="form">
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login"  onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="form__control ${properties.kcFormGroupClass!}">
                    <label for="username" class="form__label ${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("username")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="form__input ${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="form__input ${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <span id="input-error" class="form__control--error ${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </#if>
                </div>

                <div class="form__control ${properties.kcFormGroupClass!}">
                    <label for="password" class="form__label ${properties.kcLabelClass!}">${msg("password")}</label>

                    <input tabindex="2" id="password" class="form__input ${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />
                </div>


                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <button
                        tabindex="4"
                        class="form__button ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                        name="login"
                        id="kc-login"
                        type="submit"
                        value="${msg("doLogIn")}"
                    >
                        Войти
                    </button>
                </div>
            </form>
        </#if>
        </div>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>