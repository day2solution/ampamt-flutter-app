import 'dart:async';
import 'dart:convert';

import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditions extends StatefulWidget{
  @override
  _TermsAndConditionsState createState()=>_TermsAndConditionsState();

}
class _TermsAndConditionsState extends State<TermsAndConditions>{
  String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head>
<style>
* {
  color: #fff;
}
body{
    background-color: #5C0202;
}
.content {
  display: flex;
  margin: 10px auto;
  padding: 0 10px;
 font-size:12px;
  flex-direction: column;
  align-items: center;
}
</style>
<title>Terms & Conditions</title>
</head>
<body>
 <div class="content" role="main">

  
    <h3><b><u>TERMS AND CONDITIONS</u></b></h3>
    <p>Please read these Terms and Conditions of use carefully. By using this Site, you agree to abide by these Terms and
    Conditions, which will constitute our Agreement(“Agreement”).


    Welcome to the “AMPAMT” (“APP”) and related applications (collectively this “Site”), which is owned and operated by
    “Alternative Medical Practice And Medicine Treatment” (“Company”). This Site is provided solely to assist
    individuals
    in gathering sports information, searching for and connecting with sports operators offering sports services,
    posting
    opinions on sports related experiences, for booking sports experiences and courses, for tracking customers’ history
    and for no other purpose. The following terms and conditions, together with any documents they expressly incorporate
    by reference (collectively, this “Agreement"), govern your access to and use of the Site including any content,
    functionality and services offered on or through the Site whether as a guest or a registered member. The term “you”
    refers to the individual visiting the Site and/or contributing content on this Site and/or making a booking on this
    Site.

    Please read this Agreement carefully before you start to use the Site. By using the Site or by clicking to accept or
    agree to this Agreement when this option is made available to you, you accept and agree to be bound and abide by
    this
    Agreement and our Privacy Policy, incorporated herein by reference. If you do not want to agree to this Agreement or
    the Privacy Policy, you must not access or use the Site.</p>
    
    <h3><b><u>Changes to this Agreement</u></b></h3>
   
    <p>We may revise and update this Agreement from time to time in our sole discretion. All changes are effective
    immediately when we post them, and apply to all access to and use of the Site thereafter. However, any changes to
    the
    dispute resolution provisions set forth in Dispute Resolution will not apply to any disputes for which the parties
    have actual notice on or prior to the date the change is posted on the Site. Your continued use of the Site
    following
    the posting of revised Agreement means that you accept and agree to the changes.</p>
    
    <h3><b><u>Accessing the Site and Account Security</u></b></h3>
   
    <p>We reserve the right to withdraw or amend this Site, and any service or material we provide on the Site, in our sole
    discretion without notice. We will not be liable if for any reason all or any part of the Site is unavailable at any
    time or for any period. From time to time, we may restrict access to some parts of the Site, or the entire Site, to
    users, including registered members.
    <br/><br/>
    You are responsible for :
    <br/><br/>
    a) Making all arrangements necessary for you to have access to the Site.
    <br/><br/>
    b) Ensuring that all persons who access the Site through your internet connection are aware of this Agreement and
    comply
    with them.
    <br/><br/>
    To access the Site or some of the resources it offers, you may be asked to provide certain registration details or
    other information. You may register to utilize this Site by signing up and completing the registration page and
    providing us with current, complete and accurate information as requested by the online registration form. You agree
    that all information you provide to register with this Site or otherwise, including but not limited to through the
    use
    of any interactive features on the Site, is governed by our Privacy Policy, and you consent to all actions we take
    with respect to your information consistent with our Privacy Policy.
    <br/>
    <br/>

    If you choose, or are provided with, a user name, password or any other piece of information as part of our security
    procedures, you must treat such information as confidential, and you must not disclose it to any other person or
    entity. You also acknowledge that your account is personal to you and agree not to provide any other person with
    access to this Site or portions of it using your user name, password or other security information. You agree to
    notify us immediately of any unauthorized access to or use of your user name or password or any other breach of
    security. You also agree to ensure that you exit from your account at the end of each session. You should use
    particular caution when accessing your account from a public or shared computer so that others are not able to view
    or
    record your password or other personal information.
    <br/>
    We have the right to disable any user name, password or other identifier, whether chosen by you or provided by us,
    at
    any time in our sole discretion for any or no reason, including if, in our opinion, you have violated any provision
    of
    this Agreement.</p>
    <br/>
    <h3><b><u>Intellectual Property Rights</u></b></h3>
    <br/>
    <p>The Site and its entire contents, features and functionality (including but not limited to all information,
    software,
    text, displays, images, video and audio, and the design, selection and arrangement thereof), are owned by the APP,
    its
    licensors or other providers of such material and are protected by Indian copyright, trademark, patent, trade secret
    and other intellectual property or proprietary rights laws.
    <br/><br/>
    This Agreement permits you to use the Site for your personal, non-commercial use only. You must not reproduce,
    distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store or
    transmit any of the material on our Site, except as follows:
    <br/><br/>
    a) Your computer may temporarily store copies of such materials in RAM incidental to your accessing and viewing those
    materials.
    <br/><br/>
    b) You may store files that are automatically cached by your Web browser for display enhancement purposes.
    <br/><br/>
    c) You may print or download one copy of a reasonable number of pages of the Site for your own personal, non-commercial
    use and not for further reproduction, publication or distribution.
    <br/><br/>
    d) You may share sports itineraries, travel plans and other travel related information that is available on the Site
    with
    your friends and families for their own personal, non-commercial use.
    <br/><br/>
    e) If we provide desktop, mobile or other applications for download, you may download a single copy to your computer or
    mobile device solely for your own personal, non-commercial use, provided you agree to be bound by our end user
    license agreement for such applications.
    <br/><br/>
    f) We provide social media features Facebook and Instagram with certain content, you maytake such actions as are
    enabled
    by such features.
    <br/><br/>
    g) You must not:
    <br/><br/>
    i. Modify copies of any materials from this site.
    <br/><br/>
    ii. Use any illustrations, photographs, video or audio sequences or any graphics separately from the accompanying text.
    <br/><br/>
    ii. Delete or alter any copyright, trademark or other proprietary rights notices from copies of materials from this
    site.
    <br/><br/>
    You must not access or use for any commercial purposes any part of the Site or any services or materials available
    through the Site.
    If you wish to make any use of material on the Site other than that set out in this section, please address your
    request to: ampamt.india@gmail.com.
    If you print, copy, modify, download or otherwise use or provide any other person with access to any part of the
    Site
    in breach of this Agreement, your right to use the Site will cease immediately and you must, at our option, return
    or
    destroy any copies of the materials you have made. No right, title or interest in or to the Site or any content on
    the
    Site is transferred to you, and all rights not expressly granted are reserved by the APP. Any use of the Site not
    expressly permitted by this Agreement is a breach of this Agreement and may violate copyright, trademark and other
    laws.</p>
   
    <h3><b><u>Intellectual Property Rights</u></b></h3>
   
    <p>The APP name, the terms “APP”, the APP logo and all related names, logos, product and service names, designs and
    slogans are trademarks of the APPor its affiliates or licensors. You must not use such marks without the prior
    written
    permission of The APP. All other names, logos, product and service names, designs and slogans on this Site are the
    trademarks of their respective owners.</p>
   
    <h3><b><u>Prohibited Uses</u></b></h3>
   
    <p>You may use the Site only for lawful purposes and in accordance with this Agreement. You agree not to use the Site:
    <br/><br/>
    a) In any way that violates any applicable, state, local or central law or regulation.
    <br/><br/>
    b) For the purpose of exploiting, harming or attempting to exploit or harm minors in any way by exposing them to
    inappropriate content, asking for personally identifiable information or otherwise.
    <br/><br/>
    c) To send, knowingly receive, upload, download, use or re-use any material which does not comply with the Content
    Standards as set out in this Agreement.
    <br/><br/>
    d) To transmit, or procure the sending of, any advertising or promotional material, including any "junk mail", "chain
    letter" or "spam" or any other similar solicitation.
    <br/><br/>
    e) To impersonate or attempt to impersonate the APP, the APP’s employee, another user or any other person or entity
    (including, without limitation, by using e-mail addresses or screen names associated with any of the foregoing).
    <br/><br/>
    e) To engage in any other conduct that restricts or inhibits anyone's use or enjoyment of the Site, or which, as
    determined by us, may harm the APP or users of the Site or expose them to liability.
    <br/><br/>
    g) Additionally, you agree not to:
    <br/><br/>
    i. Use the Site in any manner that could disable, overburden, damage, or impair the site or interfere with any other
    party's use of the Site, including their ability to engage in real time activities through the Site.
    <br/><br/>
    ii. Use any robot, spider or other automatic device, process or means to access the Site for any purpose, including
    monitoring or copying any of the material on the Site.
    <br/><br/>
    iii. Use any manual process to monitor or copy any of the material on the Site or for any other unauthorized purpose
    without our prior written consent.
    <br/><br/>
    iv. Use any device, software or routine that interferes with the proper working of the Site.
   <br/><br/>
    v. Introduce any viruses, trojan horses, worms, logic bombs or other material which is malicious or technologically
    harmful.
    <br/><br/>
    vi. Attempt to gain unauthorized access to, interfere with, damage or disrupt any parts of the Site, the server on which
    the Site is stored, or any server, computer or database connected to the Site.
    <br/><br/>
    vii. Attack the Site via a denial-of-service attack or a distributed denial-of-service attack.
    <br/><br/>
    viii. Otherwise attempt to interfere with the proper working of the Site.</p>
   
    <h3><b><u>Member Contributions</u></b></h3>
    
    <p>The Site may contain message boards, chat rooms, personal web pages or profiles, forums, bulletin boards and other
    interactive features (collectively, "Interactive Services") that allow users to post, submit, publish, display or
    transmit to other users or other persons (hereinafter, "post") content or materials (collectively, "Member
    Contributions") on or through the Site.
    <br/> <br/>
    All Member Contributions must comply with the Content Standards set out in this Agreement.
    <br/> <br/>
    Any Member Contribution you post to the site will be considered non-confidential and non-proprietary. By providing
    any
    Member Contribution on the Site, you grant us and our affiliates and service providers, and each of their and our
    respective licensees, successors and assigns the right to use, reproduce, modify, perform, display, distribute and
    otherwise disclose to third parties any such material according to your account settings.
    <br/> <br/>
    You represent and warrant that:
    <br/> <br/>
    a) You own or control all rights in and to the Member Contributions and have the right to grant the license granted
    above
    to us and our affiliates and service providers, and each of their and our respective licensees, successors and
    assigns.

    b) All of your Member Contributions do and will comply with this Agreement.
    <br/> <br/>
    You understand and acknowledge that you are responsible for any Member Contributions you submit or contribute, and
    you, not the APP, have fully responsibility for such content, including its legality, reliability, accuracy and
    appropriateness.
    <br/> <br/>
    We are not responsible, or liable to any third party, for the content or accuracy of any Member Contributions posted
    by you or any other user of the Site.</p>
    <br/>
    <h3><b><u>Monitoring,Enforcement andTermination :</u></b></h3>
   
    <p>You represent and warrant that:
      <br/> <br/>
    a) Remove or refuse to post any Member Contributions for any or no reason in our sole discretion.
    <br/> <br/>
    b) Take any action with respect to any Member Contribution that we deem necessary or appropriate in our sole
    discretion,
    including if we believe that such Member Contribution violates this Agreement, including the Content Standards,
    infringes any intellectual property right or other right of any person or entity, threatens the personal safety of
    users or Members of the Site or the public or could create liability for The APP.
    <br/> <br/>
    c) Disclose your identity or other information about you to any third party who claims that material posted by you
    violates their rights, including their intellectual property rights or their right to privacy.
    <br/> <br/>
    d) Take appropriate legal action, including without limitation, referral to law enforcement, for any illegal or
    unauthorized use of the Site.
    <br/> <br/>
    e) Terminate or suspend your access to all or part of the Site for any or no reason, including without limitation, any
    violation of this Agreement.
    <br/> <br/>
    Without limiting the foregoing, we have the right to fully cooperate with any law enforcement authorities or court
    order requesting or directing us to disclose the identity or other information of anyone posting any materials on or
    through the Site. YOU WAIVE AND HOLD HARMLESS THE APP AND ITS AFFILIATES, LICENSEES AND SERVICE PROVIDERSFROM ANY
    CLAIMS RESULTING FROM ANY ACTION TAKEN BY THE APP ORANY OF THE FOREGOING PARTIES DURING OR AS A RESULT OF ITS
    INVESTIGATIONS AND FROM ANY ACTIONS TAKEN AS A CONSEQUENCE OF INVESTIGATIONS BY EITHER SUCH PARTIES OR LAW
    ENFORCEMENT
    AUTHORITIES.
    <br/> <br/>
    However, we do not undertake to review all material before it is posted on the Site, and cannot ensure prompt
    removal
    of objectionable material after it has been posted. Accordingly, we assume no liability for any action or inaction
    regarding transmissions, communications or content provided by any user or third party. We have no liability or
    responsibility to anyone for performance or non-performance of the activities described in this section.
  </p>
  <h3><b><u>Content Standards</u></b></h3>
<p>
    These content standards apply to any and all Member Contributions and use of Interactive Services. Member
    Contributions must in their entirety comply with all applicable, state, local and central laws and regulations.
    Without limiting the foregoing, Member Contributions must not:
    <br/><br/>
   a) Contain any material which is defamatory, obscene, indecent, abusive, offensive, harassing, violent, hateful,
    inflammatory or otherwise objectionable.
    <br/><br/>
    b) Promote sexually explicit or pornographic material, violence, or discrimination based on race, caste, sex, religion,
    nationality, disability, sexual orientation or age.
    <br/><br/>
    c) Infringe any patent, trademark, trade secret, copyright or other intellectual property or other rights of any other
    person.
    <br/><br/>
    d) Violate the legal rights (including the rights of publicity and privacy) of others or contain any material that
    could give rise to any civil or criminal liability under applicable laws or regulations or that otherwise may be in
    conflict with this Agreement and ourPrivacy Policy.
    <br/><br/>
    e) Be likely to deceive any person.
    <br/><br/>
    f) Promote any illegal activity, or advocate, promote or assist any unlawful act.
    <br/><br/>
    g) Cause annoyance, inconvenience or needless anxiety or be likely to upset, embarrass, alarm or annoy any other
    person.
    <br/><br/>
    h) Impersonate any person, or misrepresent your identity or affiliation with any person or organization.
    <br/><br/>
    i) Involve commercial activities or sales, such as contests, sweepstakes and other sales promotions, barter or
    j) advertising.
    <br/><br/>
    Give the impression that they emanate from or are endorsed by us or any other person or entity, if this is not the
    case.</p>

    <h3><b><u>Copyright Infringement</u></b></h3>

  <p>If you believe that any Member Contributions violate your copyright, please see our Copyright Policy for
    instructions
    on sending us a notice of copyright infringement. It is the policy of the APP to terminate the user accounts of
    repeat
    infringers.</p>

    <h3><b><u>Reliance on Information Posted</u></b></h3>

    <p>The information presented on or through the Site is made available solely for general information purposes. We do
    not
    warrant the accuracy, completeness or usefulness of this information. Any reliance you place on such information is
    strictly at your own risk. We disclaim all liability and responsibility arising from any reliance placed on such
    materials by you or any other visitor to the Site, or by anyone who may be informed of any of its contents.
    <br/><br/>
    This Site includes content provided by third parties, including materials provided by other members, users, and
    third-party licensors, third party content applications, syndicators, aggregators and/or reporting services. All
    statements and/or opinions expressed in these materials, and all articles and responses to questions and other
    content, other than the content provided by the APP, are solely the opinions and the responsibility of the person or
    entity providing those materials. These materials do not necessarily reflect the opinion of the APP. We are not
    responsible, or liable to you or any third party, for the content or accuracy of any materials provided by any third
    parties.</p>

    <h3><b><u>Changes to the Site</u></b></h3>

    <p>We may update the content on this Site from time to time, but its content is not necessarily complete or up-to-date.
    Any of the material on the Site may be out of date at any given time, and we are under no obligation to update such
    material.</p>

    <h3><b><u>Booking Policy and Other Terms and Conditions</u></b></h3>

    <p>All purchases through our site or other transactions for the booking of trips formed through the Site or as a result
    of visits made by you are governed by our Booking Policy, which are hereby incorporated into this Agreement.
    Additional terms and conditions may also apply to specific portions, services or features of the Site. All such
    additional terms and conditions are hereby incorporated by this reference into this Agreement.
    <br/><br/>
    Any refunds made for cancellations by the customer 30 days in advance will be charged 5% of the total amount per
    person to cover transaction charges.</p>

    <h3><b><u>Service Provider Terms and Conditions</u></b></h3>

    <p>You agree to abide by the terms and conditions of a purchase imposed by a service provider with whom you elect to
    deal, including payments of all amounts when due and compliance with the operator’s rules and restrictions regarding
    availability and use of products and services.</p>

    <h3><b><u>Currency Rate</u></b></h3>

    <p>Currency rates are based on various publicly available sources and should be used as guidelines only. Rates are not
    verified as accurate, and actual rates may vary. Currency quotes may not be updated on a daily basis. The
    information
    supplied by this Site is believed to be accurate, but the APP does not warrant or guarantee such accuracy. When
    using this information for any financial purpose, we advise you to consult a qualified professional to verify the accuracy
    of the currency rates. We do not authorize the use of this information for any purpose other than your personal use
    and you are expressly prohibited from the resale, redistribution, and use of this information for commercial
    purposes.</p>

    <h3><b><u>Linking to the Site and Social Media Features</u></b></h3>

    <p>You may link to our homepage, provided you do so in a way that is fair and legal and does not damage our reputation
    or
    take advantage of it, but you must not establish a link in such a way as to suggest any form of association,
    approval
    or endorsement on our part without our express written consent. This Site may provide certain social media features
    that enable you to:
    <br/><br/>
    a) Link from your own or certain third-party Sites to certain content on this Site.
    <br/><br/>
    b) Send e-mails or other communications with certain content, or links to certain content, on this Site.
    <br/><br/>
    Limited portions of content on this Site to be displayed or appear to be displayed on your own or certain
    third-party
    Sites. You may use these features solely as they are provided by us and solely with respect to the content that are
    displayed with and otherwise in accordance with any additional terms and conditions we provide with respect to such
    features. Subject to the foregoing, you must not:
    <br/><br/>
    a) Establish a link from any Site that is not owned by you.
    <br/><br/>
    b) Cause the Site or portions of it to be displayed, or appear to be displayed by, for example, framing, deep linking
    or in-line linking, on any other site.
    <br/><br/>
    c) Link to any part of the Site other than the homepage.
    <br/><br/>
    d) Otherwise take any action with respect to the materials on this Site that is inconsistent with any other provision
    of this Agreement.
    <br/><br/>
    The Site from which you are linking, or on which you make certain content accessible, must comply in all respects
    with the Content Standards set out in this Agreement.
    <br/><br/>
    You agree to cooperate with us in causing any unauthorized framing or linking immediately to cease. We reserve the
    right to withdraw linking permission without notice.
    <br/><br/>
    We may disable all or any social media features and any links at any time without notice in our discretion.</p>

    <h3><b><u>Links from the Site</u></b></h3>

    <p>If the Site contains links to other sites and resources provided by third parties, these links are provided for your
    convenience only. This includes links contained in advertisements, including banner advertisements and sponsored
    links. We have no control over the contents of those sites or resources, and accept no responsibility for them or
    for
    any loss or damage that may arise from your use of them. If you decide to access any of the third party Sites linked
    to this Site, you do so entirely at your own risk and subject to the terms and conditions of use for such Sites.</p>

    <h3><b><u>Geographic Restrictions</u></b></h3>

    <p>We make no claims that the Site or any of its content is accessible or appropriate outside of India. Access to the
    Site may not be legal by certain persons or in certain countries. If you access the Site from outside India, you do
    soon your own initiative and are responsible for compliance with local Indian laws.</p>

    <h3><b><u>Disclaimer of Warranties</u></b></h3>

    <p>You understand that we cannot and do not guarantee or warrant that files available for downloading from the internet
    or the Site will be free of viruses or other destructive code. You are responsible for implementing sufficient
    procedures and checkpoints to satisfy your particular requirements for anti-virus protection and accuracy of data
    input and output, and for maintaining a means external to our site for any reconstruction of any lost data. WE WILL
    NOT BE LIABLE FOR ANY LOSS OR DAMAGE CAUSED BY A DISTRIBUTED DENIAL-OF-SERVICE ATTACK, VIRUSES OR OTHER
    TECHNOLOGICALLY HARMFUL MATERIAL THAT MAY INFECT YOUR COMPUTER EQUIPMENT, COMPUTER PROGRAMS, DATA OR OTHER
    PROPRIETARY
    MATERIAL DUE TO YOUR USE OF THE SITE OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SITE OR TO YOUR DOWNLOADING OF
    ANY
    MATERIAL POSTED ON IT, OR ON ANY SITE LINKED TO IT.
    <br/><br/>
    YOUR USE OF THE SITE, ITS CONTENT AND ANY SERVICES OR ITEMS OBTAINED THROUGH THE SITE IS AT YOUR SOLE RISK.
    <br/><br/>
    THE SITE, ITS CONTENT AND ANY SERVICES OR ITEMS OBTAINED THROUGH THE SITE ARE PROVIDED ON AN "AS IS" AND "AS
    AVAILABLE" BASIS, WITHOUT ANY WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED. NEITHER THE APP NOR ANY PERSON
    ASSOCIATED WITH THE APP MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY,
    RELIABILITY,
    QUALITY, ACCURACY OR AVAILABILITY OF THE SITE. WITHOUT LIMITING THE FOREGOING, NEITHER THE APP NOR ANYONE ASSOCIATED
    WITH THE APP REPRESENTS OR WARRANTS THAT THE SITE, ITS CONTENT OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SITE
    WILL
    BE ACCURATE, RELIABLE, ERROR-FREE OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT OUR SITE OR THE SERVER THAT
    MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SITE OR ANY SERVICES OR ITEMS
    OBTAINED
    THROUGH THE SITE WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS.
    <br/><br/>
    TO THE FULLEST EXTENT PERMISSIBLE BY APPLICABLE LAW, THE APP AND ITS AFFILIATES HEREBY DISCLAIMS ALL WARRANTIES OF
    ANY
    KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF
    MERCHANTABILITY, WARRANTIES OF TITLE, NON-INFRINGEMENT AND FITNESS FOR PARTICULAR PURPOSE. NO ORAL OR WRITTEN
    INFORMATION PROVIDED BY THE APP OR ITS AFFILIATES, OFFICERS, DIRECTORS, EMPLOYEES, AGENTS, PROVIDERS, MERCHANTS,
    SPONSORS, LICENSORS OR THE LIKE SHALL CREATE A WARRANTY; NOR SHALL YOU RELY ON ANY SUCH INFORMATION OR ADVICE.
    <br/><br/>
    YOU ACKNOWLEDGE THAT THE APP DOES NOT CONTROL IN ANY RESPECT ANY INFORMATION, PRODUCTS OR SERVICES OFFERED BY THIRD
    PARTIES ON OR THROUGH THIS SITE. EXCEPT AS OTHERWISE AGREED IN WRITING, THE APP AND ITS AFFILIATES ASSUME NO
    RESPONSIBILITY FOR AND MAKE NO WARRANTY OR REPRESENTATION AS TO THE ACCURACY, CURRENCY, COMPLETENESS, RELIABILITY OR
    USEFULNESS OF CONTENT OR SERVICES DISTRIBUTED OR MADE AVAILABLE BY THIRD PARTIES THROUGH THIS SITE. PRICES AND
    AVAILABILITY ARE SUBJECT TO CHANGE AT ANY TIME PRIOR TO PURCHASE. THE APP DISCLAIMS ALL LIABILITY FOR ANY ERRORS OR
    OTHER INACCURACIES RELATING TO THE INFORMATION AND DESCRIPTION OF THE TRAVEL SERVICES AND TRAVEL PRODUCTS DISPLAYED
    ON
    THIS SITE (INCLUDING, WITHOUT LIMITATION, THE PRICING, PHOTOGRAPHS, LIST OF HOTEL AMENITIES, GENERAL PRODUCT
    DESCRIPTIONS, ETC.). IN ADDITION, THE APP EXPRESSLY RESERVES THE RIGHT TO UPDATE PRICES AT ANY TIME AND/OR CORRECT
    ANY
    PRICING ERRORS ON OUR SITE AND/OR ON PENDING RESERVATIONS MADE UNDER AN INCORRECT PRICE.
    <br/><br/>
    THE APP DOES NOT MAKE ANY WARRANTY THAT THIS SITE OR ITS CONTENT WILL MEET YOUR REQUIREMENTS, OR THAT THE SITE OR
    CONTENT WILL BE UNINTERRUPTED, TIMELY, SECURE OR ERROR FREE, OR THAT DEFECTS, IF ANY, WILL BE CORRECTED. THE APP
    DOES
    NOT REPRESENT OR WARRANT THAT MATERIALS IN THIS SITE OR INFORMATION PROVIDED BY THE APP VIA EMAIL OR OTHER MEANS ARE
    ACCURATE, COMPLETE, RELIABLE, CURRENT OR ERROR-FREE. NOR DOES THE APP MAKE ANY WARRANTY AS TO THE RESULTS THAT MAY
    BE
    OBTAINED FROM USE OF THE APP OR ITS CONTENT OR AS TO THE ACCURACY, COMPLETENESS OR RELIABILITY OF ANY INFORMATION
    OBTAINED THROUGH USE OF THE SITE.
    <br/><br/>
    THE APP ASSUMES NO RESPONSIBILITY FOR ANY DAMAGES SUFFERED BY A MEMBER OR USER, INCLUDING, BUT NOT LIMITED TO, LOSS
    OF
    DATA FROM DELAYS, NONDELIVERIES OF CONTENT OR EMAIL, ERRORS, SYSTEM DOWN TIME, MISDELIVERIES OF CONTENT OR EMAIL,
    NETWORK OR SYSTEM OUTAGES, FILE CORRUPTION OR SERVICE INTERRUPTIONS CAUSED BY THE NEGLIGENCE OF THE APP, ITS
    AFFILIATES, ITS LICENSORS OR A MEMBER OR USER’S OWN ERRORS AND/OR OMISSIONS.
    <br/><br/>
    THE APP ASSUMES NO RESPONSIBILITY FOR ANY DAMAGES SUFFERED BY A USER OR MEMBER INCLUDING, BUT NOT LIMITED TO, LOSS
    FROM NONDELIVERY OF SERVICES PURCHASED FROM TRAVEL OPERATORS OR COMPANIES LISTED ON THE APP SUCH AS (BUT NOT LIMITED
    TO) HOTELS, TOURS, TRANSFERS AND VOUCHERS. THE MEMBER OR USER IS AWARE THAT THE TRAVEL OPERATORS OR COMPANIES AND
    THEIR AGENTS PROVIDING SUCH SERVICES ARE NOT IN ANY WAY RELATED TO THE APP AND THE APPHAS NO RESPONSIBILITY TO
    ENSURE
    DELIVERY OF SUCH SERVICES.
    THE APP DISCLAIMS ANY WARRANTY OR REPRESENTATION THAT CONFIDENTIALITY OF INFORMATION TRANSMITTED THROUGH THIS
    WEBSITE
    WILL BE MAINTAINED.</p>
    
    <h3><b><u>Limitation on Liability</u></b></h3>

    <p>IN NO CIRCUMSTANCE, INCLUDING WITHOUT LIMITATION NEGLIGENCE, SHALL THE APP OR ITS PARENTS, SUBSIDIARIES OR
    AFFILIATES
    OR THEIR LICENSORS, EMPLOYEES, AGENTS, OFFICERS, DIRECTORS OR ANY OTHER PARTY INVOLVED IN CREATING, PRODUCING,
    TRANSMITTING, OR DISTRIBUTING THE APP CONTENT (COLLECTIVELY THE “COVERED PARTIES”) BE LIABLE TO ANY PERSON OR ENTITY
    WHATSOEVER FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, COMPENSATORY, PUNITIVE OR CONSEQUENTIAL DAMAGES, INCLUDING
    BUT NOT LIMITED TO, PERSONAL INJURY, PAIN AND SUFFERING, EMOTIONAL DISTRESS, LOSS OF REVENUE, LOSS OF GOODWILL, LOSS
    OF DATA, AND WHETHER CAUSED BY TORT (INCLUDING NEGLIGENCE), BREACH OF CONTRACT OR OTHERWISE, EVEN IF FORESEEABLE
    ARISING FROM OR IN CONNECTION WITH THE USE OR INABILITY TO USE THE SITE OR ANY CONTENT PROVIDED BY OR THROUGH THIS
    SITE OR ANY PRODUCTS OR SERVICES OBTAINED THORUGH THE SITE OR RESULTING FROM UNAUTHORIZED ACCESS TO OR ALTERATION OF
    YOUR TRANSMISSIONS OR DATA, OR OTHER INFORMATION THAT IS SENT OR RECEIVED, INCLUDING BUT NOT LIMITED TO DAMAGES FOR
    LOST PROFITS, LOSS OF BUSINESS OR ANTICIPATED SAVINGS, USE, DATA OR OTHER INTANGIBLES. THE LIMITATIONS OF LIABILITY
    SHALL APPLY REGARDLESS OF THE FORM OF ACTION, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR
    OTHERWISE, EVEN IF A COVERED PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
    <br/><br/>
    FURTHER, THE TRAVEL OPERATORS OR SERVICE PROVIDER ON THE SITE ARE INDEPENDENT CONTRACTORS AND NOT AGENTS OR
    EMPLOYEES
    OF THE COVERED PARTIES. TO THE EXTENT PERMITTED BY LAW, THE COVERED PARTIES DO NOT ASSUME LIABILITY FOR ANY INJURY,
    DAMAGE, DEATH, PROPERTY DAMAGE, LOSS, ACCIDENT OR DELAY DUE TO AN ACT, ERROR OR OMISSION OF A TRAVEL OPERATOR OR
    SERVICE PROVIDER, INCLUDING, WITHOUT LIMITATION, AN ACT OF NEGLIGENCE OR THE DEFAULT OF A SERVICE PROVIDER, OR AN
    ACT
    OF GOD. THE COVERED PARTIES SHALL HAVE NO LIABILITY AND WILL MAKE NO REFUND IN THE EVENT OF ANY DELAY, CHANGE IN
    ITINERARY, OTHER CHANGES TO THE TRAVEL PACKAGE, CANCELLATION, OVERBOOKING, STRIKE, FORCE MAJEURE OR OTHER CAUSES
    BEYOND THEIR DIRECT CONTROL, AND THEY HAVE NO RESPONSIBILITY FOR ANY ADDITIONAL EXPENSE, OMISSIONS, DELAYS,
    RE-ROUTING
    OR ACTS OF ANY GOVERNMENT OR AUTHORITY.
    <br/><br/>
    IF, NOTWITHSTANDING THE ABOVE, A COVERED PARTY IS FOUND LIABLE FOR ANY LOSS OR DAMAGE RELATING TO THE USE OF THIS
    SITE, YOU AGREE THE LIABILITY OF ANY SUCH PARTY SHALL IN NO EVENT EXCEED THE TRANSACTION FEES ASSESSED BY THE APP
    FOR
    YOUR TRANSACTION ON THIS SITE. THIS LIMITATION OF LIABILITY REFLECTS THE ALLOCATION OF RISK BETWEEN THE PARTIES.

    THE FOREGOING DOES NOT AFFECT ANY LIABILITY WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW.</p>
   
    <h3><b><u>Indemnification</u></b></h3>

    <p>You agree to defend, indemnify and hold harmless THE APP and the Covered Parties (defined above) from and against
    any
    claims, liabilities, damages, judgments, awards, losses, costs, expenses or fees (including reasonable attorneys'
    fees) arising out of or relating to your violation of this Agreement or your use of the Site, including, but not
    limited to, your Member Contributions, any use of the Site's content, services and products other than as expressly
    authorized in this Agreement or your use of any information obtained from the Site.</p>

    <h3><b><u>Dispute Resolution and Governing Law</u></b></h3>

    <p>This Agreement is governed by Indian Laws. Any and all controversies, disputes, demands, counts, claims, or causes
    of
    action (including the interpretation and scope of this clause), legal suit, action or proceeding arising out of, or
    related to, this Agreement or the Site between you and THE APP and our employees, agents, successors, or assigns,
    shall exclusively be settled through the courts of competent jurisdiction in Mumbai, India.</p>

    <h3><b><u>Waiver and Severability</u></b></h3>

    <p>No waiver of by THE APP of any term or condition set forth in this Agreement shall be deemed a further or continuing
    waiver of such term or condition or a waiver of any other term or condition, and any failure of THE APP to assert a
    right or provision under this Agreement shall not constitute a waiver of such right or provision. If any provision
    of
    this Agreement is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or
    unenforceable
    for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining
    provisions
    of this Agreement will continue in full force and effect.</p>

    <h3><b><u>Entire Agreement</u></b></h3>

    <p>This Agreement and our Privacy Policy constitute the sole and entire agreement between you and THE APP with respect
    to
    the Site and supersede all prior and contemporaneous understandings, agreements, representations and warranties,
    both
    written and oral, with respect to the Site.</p>
 

  </div>
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/icon.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Terms & Conditions'))
          ],
        ),
      ),
       body: Container(
         color: CompanyStyle.primaryColor,
          //  padding: EdgeInsets.all(5.0),
          child: Column(
            children:  <Widget>[
               Expanded(
                 child:WebView(
                   initialUrl: 'https://ampamt.com/#/terms-conditions',
                   javascriptMode: JavascriptMode.unrestricted,
                   onWebViewCreated: (WebViewController webViewController) {
                     // _controller.complete(webViewController);
                     final String contentBase64 = base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
                     webViewController.loadUrl('data:text/html;base64,$contentBase64');

                   },
                   onProgress: (int progress) {
                     print("WebView is loading (progress : $progress%)");
                   },
                   javascriptChannels: <JavascriptChannel>{
                     _toasterJavascriptChannel(context),
                   },
                   navigationDelegate: (NavigationRequest request) {
                     if (request.url.startsWith('https://www.ampamt.com/')) {
                       print('blocking navigation to $request}');
                       return NavigationDecision.prevent;
                     }
                     print('allowing navigation to $request');
                     return NavigationDecision.navigate;
                   },
                   onPageStarted: (String url) {
                     print('Page started loading: $url');
                   },
                   onPageFinished: (String url) {
                     print('Page finished loading: $url');
                     Text("Hi");
                   },
                   gestureNavigationEnabled: true,
                 ) ,
               ),
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child:ElevatedButton(
                  style: CompanyStyle.getButtonStyle(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Text('I ACCEPT',),
                    width: double.infinity,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
            ],
          )
       ),
    );
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}