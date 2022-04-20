/*******************************************************************************
 * this user.js file was prepared for Firefox v96 with help from
 * the following GitHub projects -
 * https://github.com/arkenfox/user.js     [git commit ab7380c]
 * and other sources on the Internet
 * NOTE: this file is made only for the master profile
 ******************************************************************************/

/*
  INDEX:
  0100: STARTUP
  0200: GEOLOCATION / LANGUAGE / LOCALE
  0300: QUIETER FOX
  0400: SAFE BROWSING
  0600: BLOCK IMPLICIT OUTBOUND
  0700: DNS / DoH / PROXY / SOCKS / IPv6
  0800: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
  0900: PASSWORDS
  1000: DISK AVOIDANCE
  1200: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
  1400: FONTS
  1600: HEADERS / REFERERS
  1700: CONTAINERS
  2000: PLUGINS / MEDIA / WEBRTC
  2400: DOM (DOCUMENT OBJECT MODEL)
  2600: MISCELLANEOUS
  2700: ETP (ENHANCED TRACKING PROTECTION)
  2800: SHUTDOWN & SANITIZING
  4500: RFP (RESIST FINGERPRINTING)
  5000: OPTIONAL OPSEC
  5500: OPTIONAL HARDENING
  6000: DON'T TOUCH
  7000: DON'T BOTHER
  8000: DON'T BOTHER: FINGERPRINTING
  9000: PERSONAL
  9999: DEPRECATED / REMOVED / LEGACY / RENAMED
*/

/* 0000 */
user_pref("browser.aboutConfig.showWarning", false);

/* 0200 */
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
user_pref("geo.provider.use_gpsd", false);
user_pref("browser.region.network.url", "");
user_pref("browser.region.update.enabled", false);
user_pref("intl.accept_languages", "en-US, en");

/* 0300 */
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/* 0800 */
user_pref("browser.fixup.alternate.enabled", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);
user_pref("browser.urlbar.suggest.quicksuggest", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

/* 0900 */
user_pref("signon.formlessCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);

/* 1000 */
user_pref("browser.sessionstore.privacy_level", 1);
user_pref("browser.shell.shortcutFavicons", false);

/* 1200 */
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.tls.enable_0rtt_data", false);
/* this leaks your browsing history to OCSP responders and end up implementing
 * soft-fail which makes this virtually useless in terms of security */
user_pref("security.OCSP.enabled", 0);
user_pref("security.pki.sha1_enforcement_level", 1);
user_pref("security.cert_pinning.enforcement_level", 2);
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);
user_pref("security.mixed_content.block_display_content", true);
user_pref("browser.ssl_override_behavior", 1);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.insecure_connection_text.enabled", true);

/* 1600 */
user_pref("network.http.referer.XOriginPolicy", 2);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/* 1700 */
user_pref("privacy.userContext.ui.enabled", true);

/* 2000 */
user_pref("media.eme.enabled", false);
user_pref("browser.eme.ui.enabled", false);
user_pref("media.gmp-provider.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.browser.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);

/* 2400 */
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown");
user_pref("javascript.options.wasm", false);

/* 2600 */
user_pref("beacon.enabled", false);
user_pref("browser.uitour.enabled", false);
user_pref("browser.uitour.url", "");
user_pref("network.IDN_show_punycode", true);
user_pref("permissions.delegation.enabled", false);

/* 2700 */
user_pref("privacy.partition.serviceWorkers", true);

/* 4500 */
user_pref("webgl.disabled", true);

/* 5000 */
// user_pref("browser.chrome.site_icons", false);

/* 9000 */
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.quitShortcut.disabled", true);
user_pref("ui.key.menuAccessKey", 0);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("identity.fxaccounts.enabled", false);

/* MY ADDITIONS */
user_pref("ui.context_menus.after_mouseup", true);
user_pref("fission.autostart", true);

// not sure about the security or privacy implications of this but
// a lot of FFX CSS themes and addons apparently require this
user_pref("svg.context-properties.content.enabled", true);

// use devtools on my shitty 27 inch 4k monitor which can't do integer scaling
user_pref("devtools.toolbox.zoomValue", "1.5");

// KDE file picker doesn't pick up theme in sway window manager otherwise this
// is a no-brainer, GNOME file picker won't support thumbnails
// user_pref("widget.use-xdg-desktop-portal", true);

// enable hw acceleration at the cost of disabling sandboxing
// user_pref("media.ffmpeg.vaapi.enabled", true);
// user_pref("media.ffvpx.enabled", false);
// user_pref("media.rdd-vpx.enabled", false);
// user_pref("media.ffvpx.enabled", false);
