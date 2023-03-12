require ["copy", "imap4flags", "fileinto", "reject", "regex", "variables", "mailbox"];

if anyof (
    address :is :localpart ["to","cc"] ["king-arthur","agatina","cool-cooler-the_coolest","tower", "partnernews","redaktion","kingspawn","info", "nemon","blogs","lakrassa","halllofireball","fvwx","brdd","conradletter","duolingo","vergleich","m..."],
    header :contains "subject" ["Potenzpillen", "Nur fur Manner!","Gewinnmöglichkeit","make a girl turn on", "100% Original Produkte","Frauen werden Sex Mit Dir","20 St fur 45 Euro","Höhle der Löwen","Carmen hat Experten","Schnelle Lieferung die Tabletten","Dating in Deutschland","Die besten Generica","Lerne single Frauen in","Medikamente für Potenz","Kapitalspritze fur Deine Firma","Pillenversand","Royal Maca","Garantierter Kreditrahmen bis zu 20.000 Euro","Investition von Boris Becker","Mutter aus wird Millionärin","Generika Potenzmittel"],
    header :is "X-Spam-Flag" "YES",
    address "from" ["wordpress@fileserv","info.emea@altium.com"],
    address :domain "from" ["news.tisspro.de", "deal.licet-media.com","news.readscan.de","emm-r.voelkner.de","update.lieferando.de","cowcotland.com","gigabyte.de","logic2day.com","update.lieferando.de"]
)
{
    setflag "\\Seen";
    fileinto "Junk";
    stop;
}

if anyof (
    address :domain "from" ["deals.banggood.com"],
    address "from" ["promotion@aliexpress.com","news@pollin.de"]
)
{
    setflag "\\Seen";
}


if address :is :localpart ["to","cc"] ["me","david","david.bauer"]
{
    fileinto "INBOX";
    stop;
}

if address :regex :localpart ["to","cc"] "(shop|dhl|amazon|banggood|chinascheisse|alternate|3djake|aliexpress|busok|conrad|conradletter|flasshop|graffiti-berlin|itecc|koro|krass|lauflust|lauflustletter|lidl|lilabus|nkon|offgridtec|pollin|reichelt|wasd|bett1|korodrogerie)"
{
    fileinto "shops";
    stop;
}

if address :regex :localpart ["to","cc"] "(spotify|spotify2|netflix|joyn)"
{
    fileinto "streaming";
    stop;
}

if address :regex :localpart ["to","cc"] "(app.|milk|fettigesessen|park4night|wunderlist|duolingo)"
{
    fileinto "apps";
    stop;
}


if anyof (
    address :is :domain ["to","cc"] ["noreply.github.com", "github.com"],
    address :regex :localpart ["to","cc"] "(github|pypi)"
)
{
    fileinto "development";
    stop;
}

if address :regex :localpart ["to","cc"] "(arzt|todd)"
{
    fileinto "gesundheit";
    stop;
}

if address :regex :localpart ["to","cc"] "(okcupid|lena|deviance)"
{
    fileinto "dating";
    stop;
}

if address :regex :localpart ["to","cc"] "(dkb|paypal|visa)"
{
    fileinto "bank";
    stop;
}

if address :regex :localpart ["to","cc"] "(c3loc|ccc)"
{
    fileinto "chaos";
    stop;
}

if address :is :localpart ["to","cc"] "(ebay_kleinanzeigen|ebay_)"
{
    fileinto "ebay";
    stop;
}

if address :regex :localpart ["to","cc"] "(congstar|freenet|hetzner|inwx|lyca|netzclub|quix|rapidgator|shareonline|simply|telekom|gmx)"
{
    fileinto "internet";
    stop;
}

if address :regex :localpart ["to","cc"] "(selfhost|ubnt)"
{
    fileinto "server";
    stop;
}

if address :regex :localpart ["to","cc"] "(elster|foehr|goteburg|jeux|OJW|aktion|grundeinkommen)"
{
    fileinto "sonstiges";
    stop;
}

if address :regex :localpart ["to","cc"] "(admiral|huk24|rmv|wkv)"
{
    fileinto "versicherung";
    stop;
}

if address :regex :localpart ["to","cc"] "(sites.|website.|lkw|heise|itchio|autodesk|autoscout|circuitboard|foodsharing|foren|fragdenstaat|intel|microsoft|reddit|thingiverse|fusion360)"
{
    fileinto "websites";
    stop;
}


if anyof (
        header :regex "list-id" "(.*)lists\.fablab-karlsruhe\.de",
        address :is :domain ["to","cc"] "lists.fablab-karlsruhe.de"
){
    fileinto "fablab_lists";
    stop;
}

if anyof (
        address :is :domain ["to","cc"] "lists.entropia.de",
        address :regex :localpart ["to","cc"] "(whackprojekt)"
){
    fileinto "hausprojekt";
    stop;
}




if address :is :domain ["to","cc"] "fablab-karlsruhe.de"{
    fileinto "fablab";
    stop;
}

if anyof (
    header :regex "list-id" "(.*)seclists\.org",
    address :matches :localpart ["to","cc"] ["debian-security-announce","root","postmacher","webmaster"]
){
    setflag "\\Seen";
    fileinto "server";
    stop;
}

if anyof (
    header :regex "list-id" "(.*)seclists\.org",
    address :matches :localpart ["to","cc"] ["letsencrypt"]
){
    fileinto "server";
    stop;
}


if anyof(
    header :regex "To" ".*@(wikmunke.de).*$"
){
                if address :regex :localpart ["to","cc"] "([a-zA-Z]*)[\.]+([a-zA-Z]*)[0-9]*"
                {
                    set :lower "localpart" "${1}/${2}";
                    fileinto "${localpart}";
                    stop;
                }


                if address :regex :localpart ["to","cc"] "([a-zA-Z]*)[0-9]*"
                {
                    set :lower "localpart" "${1}";
                    fileinto "${localpart}";
                    stop;
                }
}

if anyof(
    header :regex "To" ".*@(debauer.net).*$"
){
                if address :regex :localpart ["to","cc"] "([a-zA-Z]*)[\.]+([a-zA-Z]*)[0-9]*"
                {
                    set :lower "localpart" "${1}";
                    fileinto "${localpart}";
                    stop;
                }


                if address :regex :localpart ["to","cc"] "([a-zA-Z]*)[0-9]*"
                {
                    set :lower "localpart" "${1}";
                    fileinto "${localpart}";
                    stop;
                }
}

fileinto "suspect";
stop;
