(function () {
  // @params: cname = (string) cookie name
  // @return: cookie value
  function getCookie(cname) {
    let name = cname + '=';
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for(let i = 0; i <ca.length; i++) {
      let c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return'';
  }

  // @params: cname = (string) storage item name
  // @return: storage item value (typically string)
  function getStorageItem(cname) {
    return localStorage.getItem(cname);
  }

  // @params: cname = (string) storage item name
  function removeStorageItem(cname) {
    localStorage.removeItem(cname);
  }

  // @params: cname = (string) storage item name
  //          value = (string) storage item value
  function setStorageItem(cname, value) {
    localStorage.setItem(cname, value);
  }

  // get opt-in storage item
  const emailOptIn = getStorageItem('email_opt_in');

  // get registration form element
  const form = document.getElementById('registration_confirmation_form');

  if (!!form) {
    // hide form fields until done loading
    document.querySelectorAll('.control-group').forEach((el) => {
      el.style.display = 'none';
    });

    // Added setTimeout to allow some time after initialization. This is for Canvas scripts to have a chance to act.
    // Since we cannot tell when it's done, we'll add a timeout here of 1s
    setTimeout(function() {
      if (emailOptIn) {
        // if, for some reason the email opt in is already set - unset it
        removeStorageItem('email_opt_in');
      }

      // remove the terms modal link
      if (document.contains(document.getElementById("terms_of_service_modal"))) {
        document.getElementById('terms_of_service_modal').remove();
      }

      // create "Instructure Acceptable Use Policy" link
      const acceptableUse = document.createElement('a');
      acceptableUse.href = 'https://www.instructure.com/policies/acceptable-use';
      acceptableUse.classList.add('terms_link');
      acceptableUse.appendChild(document.createTextNode('Instructure Acceptable Use Policy'));

      // create "AWS Learner Terms and Conditions" link
      const termsConditions = document.createElement('a');
      termsConditions.href = 'https://aws.amazon.com/legal/learner-terms-conditions/';
      termsConditions.classList.add('terms_link');
      termsConditions.appendChild(document.createTextNode('AWS Learner Terms and Conditions'));

      // create "AWS Privacy Notice" links
      const AWSPrivacy = document.createElement('a');
      AWSPrivacy.href = 'https://aws.amazon.com/privacy/';
      AWSPrivacy.classList.add('terms_link');
      AWSPrivacy.appendChild(document.createTextNode('AWS Privacy Notice'));

      // need to duplicate the "AWS Privacy Notice" for a second link
      const AWSPrivacySecond = document.createElement('a');
      AWSPrivacySecond.href = 'https://aws.amazon.com/privacy/';
      AWSPrivacySecond.classList.add('terms_link');
      AWSPrivacySecond.appendChild(document.createTextNode('AWS Privacy Notice'));

      // create "Amazon Web Services" link
      const AWServices = document.createElement('a');
      AWServices.href = 'https://aws.amazon.com/legal/marketingentities/';
      AWServices.classList.add('terms_link');
      AWServices.appendChild(document.createTextNode('Amazon Web Services'));

      // update terms content
      const termsContainer = form.querySelector('span.terms_of_service_link');
      // add content to the new container
      termsContainer.appendChild(document.createTextNode('I agree to the Canvas '));
      termsContainer.appendChild(acceptableUse);
      termsContainer.appendChild(document.createTextNode(' and to the '));
      termsContainer.appendChild(termsConditions);
      termsContainer.appendChild(document.createTextNode(' The information you provide will be handled by AWS as described in the '));
      termsContainer.appendChild(AWSPrivacy);
      termsContainer.appendChild(document.createTextNode('.'));

      // move content into the label for display purposes
      const termsLabel = form.querySelector('label[for="user_terms_of_use"].checkbox');
      // remove default text node
      termsLabel.lastChild.remove();
      // add container to label
      termsLabel.appendChild(termsContainer);

      // create checkbox
      const checkbox = document.createElement('input');
      checkbox.type = 'checkbox';
      checkbox.name = 'email_opt_in';
      checkbox.id = 'optInAWSEmails';
      checkbox.classList.add('checkbox');

      // create checkbox label
      const label = document.createElement('label');
      label.classList.add('checkbox');
      label.style = 'margin-top:0;';
      label.htmlFor = 'optInAWSEmails';

      const span = document.createElement('span')
      span.classList.add('terms_of_service_link', 'terms-of-service__link');

      // build label
      label.appendChild(checkbox);
      label.appendChild(span);

      // add text to label
      span.appendChild(document.createTextNode('Yes, I\'d like Canvas to provide my contact information to '));
      span.appendChild(AWServices);
      span.appendChild(document.createTextNode('(AWS) so AWS can share the latest news about AWS services and related offerings with me by email, post or telephone.'));
      span.appendChild(document.createElement('br'));
      span.appendChild(document.createElement('br'));
      span.appendChild(document.createTextNode('You may unsubscribe from receiving AWS news and offers from at any time by following the instructions in the communications received.  AWS handles your information as described in the '));
      span.appendChild(AWSPrivacySecond);
      span.appendChild(document.createTextNode('. Providing Canvas with your information may involve transferring it to another country.  For questions about how Canvas will handle your information, please contact Canvas directly or refer to its privacy policy.'));

      // create control-group container
      const controlGroupContainer = document.createElement('div');
      controlGroupContainer.classList.add('control-group');

      // create controls container
      const controlsContainer = document.createElement('div');
      controlsContainer.classList.add('controls');

      // append checkbox and label to input container
      controlsContainer.appendChild(label);

      // append controls container to control-group container
      controlGroupContainer.appendChild(controlsContainer);

      // append input container to form
      const submitBtn = form.querySelector('button.btn[type="submit"]');
      form.insertBefore(controlGroupContainer, submitBtn.parentNode.parentNode);

      // move termsContainer to end
      const termsContainerControlGroup = termsContainer.closest('.control-group');
      form.insertBefore(termsContainerControlGroup, submitBtn.parentNode.parentNode);

      // show all control groups again
      document.querySelectorAll('.control-group').forEach((el) => {
        el.style.display = null;
      });

      // set the email_opt_in localstorage item on checkbox value change
      checkbox.addEventListener('change', (event) => {
        // update the storage item with the latest value
        setStorageItem('email_opt_in', event.currentTarget.checked.toString());
      });
    }, 1000);

  } else if (emailOptIn) {
    // If form doesn't exist, and the localstorage item 'email_opt_in' is setterms_of_service_link
    // send the data to the custom_data API endpoint
    // then remove the storage item
    const token = getCookie('_csrf_token');
    const json = {
      'ns': 'com.unicon.canvas-app',
      'data': emailOptIn
    };
    const headers = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': token
    };

    fetch(
      '/api/v1/users/self/custom_data/email_opt_in?ns=com.unicon.canvas-app',
      {
        method: 'PUT',
        headers: headers,
        body: JSON.stringify(json)
      }
    )
    .then(() => {
      // remove storage item on submitting data
      removeStorageItem('email_opt_in');
    })
    .catch(error => console.error(error));
  }
})();