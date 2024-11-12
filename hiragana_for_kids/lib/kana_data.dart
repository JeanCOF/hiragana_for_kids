class Kana {
  final String symbol;
  final String pronounce;
  final String soundFile;
  final String hint;

  Kana({
    required this.symbol,
    required this.pronounce,
    required this.soundFile,
    required this.hint,
  });
}

final List<Kana> kanaList = [
  Kana(
      symbol: 'あ',
      pronounce: 'a',
      soundFile: 'sounds/a.mp3',
      hint: 'Find the capital A in あ.'),
  Kana(
      symbol: 'い',
      pronounce: 'i',
      soundFile: 'sounds/i.mp3',
      hint: 'A couple of eels.'),
  Kana(
      symbol: 'う',
      pronounce: 'u',
      soundFile: 'sounds/u.mp3',
      hint: 'Find the U in う.'),
  Kana(
      symbol: 'え',
      pronounce: 'e',
      soundFile: 'sounds/e.mp3',
      hint: 'An exotic bird laying eggs.'),
  Kana(
      symbol: 'お',
      pronounce: 'o',
      soundFile: 'sounds/o.mp3',
      hint: 'Two letter o symbols.'),
  Kana(
      symbol: 'か',
      pronounce: 'ka',
      soundFile: 'sounds/ka.mp3',
      hint: 'Ka is japanese for "mosquito."'),
  Kana(
      symbol: 'き', pronounce: 'ki', soundFile: 'sounds/ki.mp3', hint: 'A key.'),
  Kana(
      symbol: 'く',
      pronounce: 'ku',
      soundFile: 'sounds/ku.mp3',
      hint: 'The mouth of a cuckoo bird saying "ku ku!"'),
  Kana(
      symbol: 'け',
      pronounce: 'ke',
      soundFile: 'sounds/ke.mp3',
      hint: 'Some wiggly kelp.'),
  Kana(
      symbol: 'こ',
      pronounce: 'ko',
      soundFile: 'sounds/ko.mp3',
      hint: 'A couple of co-habitation worms.'),
  Kana(
      symbol: 'さ',
      pronounce: 'sa',
      soundFile: 'sounds/sa.mp3',
      hint: 'Chunky salsa.'),
  Kana(
      symbol: 'し',
      pronounce: 'shi',
      soundFile: 'sounds/shi.mp3',
      hint: "Shepherd's crook to herd sheep."),
  Kana(
      symbol: 'す',
      pronounce: 'su',
      soundFile: 'sounds/su.mp3',
      hint:
          'A swing doing a loop-de-loop and throwing that poor kid off of it.'),
  Kana(
      symbol: 'せ',
      pronounce: 'se',
      soundFile: 'sounds/se.mp3',
      hint: 'A set of sexy vampire teeth.'),
  Kana(
      symbol: 'そ',
      pronounce: 'so',
      soundFile: 'sounds/so.mp3',
      hint: 'A mouth slurping soda.'),
  Kana(
      symbol: 'た',
      pronounce: 'ta',
      soundFile: 'sounds/ta.mp3',
      hint: "A taco (that you're eating with a fork)."),
  Kana(
      symbol: 'ち',
      pronounce: 'chi',
      soundFile: 'sounds/chi.mp3',
      hint: 'Say cheese! that forced smile you have to make.'),
  Kana(
      symbol: 'つ',
      pronounce: 'tsu',
      soundFile: 'sounds/tsu.mp3',
      hint: 'A big wave like a tsunami.'),
  Kana(
      symbol: 'て',
      pronounce: 'te',
      soundFile: 'sounds/te.mp3',
      hint: 'A hand-held telescope.'),
  Kana(
      symbol: 'と',
      pronounce: 'to',
      soundFile: 'sounds/to.mp3',
      hint: 'A toe with a little splinter in it.'),
  Kana(
      symbol: 'な',
      pronounce: 'na',
      soundFile: 'sounds/na.mp3',
      hint: 'The nun praying in front of the cross asking for nachos.'),
  Kana(
      symbol: 'に',
      pronounce: 'ni',
      soundFile: 'sounds/ni.mp3',
      hint: 'A needle pulling a thread.'),
  Kana(
      symbol: 'ぬ',
      pronounce: 'nu',
      soundFile: 'sounds/nu.mp3',
      hint: 'Some noodles.'),
  Kana(
      symbol: 'ね',
      pronounce: 'ne',
      soundFile: 'sounds/ne.mp3',
      hint: 'It\'s nelly, the neko (Japanese for "cat").'),
  Kana(
      symbol: 'の',
      pronounce: 'no',
      soundFile: 'sounds/no.mp3',
      hint: 'A pig nose.'),
  Kana(
      symbol: 'は',
      pronounce: 'ha',
      soundFile: 'sounds/ha.mp3',
      hint: 'は looks like h + a.'),
  Kana(
      symbol: 'ひ',
      pronounce: 'hi',
      soundFile: 'sounds/hi.mp3',
      hint: 'He has a big nose.'),
  Kana(
      symbol: 'ふ',
      pronounce: 'fu',
      soundFile: 'sounds/fu.mp3',
      hint: 'A dancing fool hula hooping.'),
  Kana(
      symbol: 'へ',
      pronounce: 'he',
      soundFile: 'sounds/he.mp3',
      hint: 'The famous mountain Mt. Saint Helens.'),
  Kana(
      symbol: 'ほ',
      pronounce: 'ho',
      soundFile: 'sounds/ho.mp3',
      hint: 'A mutated santa claus uttering "ho ho ho."'),
  Kana(
      symbol: 'ま',
      pronounce: 'ma',
      soundFile: 'sounds/ma.mp3',
      hint: 'Imagine your ma looking like this. aghh!'),
  Kana(
      symbol: 'み',
      pronounce: 'mi',
      soundFile: 'sounds/mi.mp3',
      hint: 'Who just turned 21? Me!'),
  Kana(
      symbol: 'む',
      pronounce: 'mu',
      soundFile: 'sounds/mu.mp3',
      hint: '"Mooooo," says the cow.'),
  Kana(
      symbol: 'め',
      pronounce: 'me',
      soundFile: 'sounds/me.mp3',
      hint: 'Me is japanese for "eye."'),
  Kana(
      symbol: 'も',
      pronounce: 'mo',
      soundFile: 'sounds/mo.mp3',
      hint: 'To catch more fish, add more worms to your hook.'),
  Kana(
      symbol: 'や',
      pronounce: 'ya',
      soundFile: 'sounds/ya.mp3',
      hint: 'A yacht.'),
  Kana(
      symbol: 'ゆ',
      pronounce: 'yu',
      soundFile: 'sounds/yu.mp3',
      hint: 'A unique looking fish.'),
  Kana(
      symbol: 'よ',
      pronounce: 'yo',
      soundFile: 'sounds/yo.mp3',
      hint: 'Yo! Find the Y and O in よ.'),
  Kana(
      symbol: 'ら',
      pronounce: 'ra',
      soundFile: 'sounds/ra.mp3',
      hint: 'A rabbit.'),
  Kana(
      symbol: 'り',
      pronounce: 'ri',
      soundFile: 'sounds/ri.mp3',
      hint: 'The reeds are swaying in the wind.'),
  Kana(
      symbol: 'る',
      pronounce: 'ru',
      soundFile: 'sounds/ru.mp3',
      hint: 'る is a crazier route.'),
  Kana(
      symbol: 'れ',
      pronounce: 're',
      soundFile: 'sounds/re.mp3',
      hint: 'This guy is retching up his dinner.'),
  Kana(
      symbol: 'ろ',
      pronounce: 'ro',
      soundFile: 'sounds/ro.mp3',
      hint: 'A plain old road especially when compared to る.'),
  Kana(
      symbol: 'わ',
      pronounce: 'wa',
      soundFile: 'sounds/wa.mp3',
      hint: 'A wasp flying straight up.'),
  Kana(
      symbol: 'を',
      pronounce: 'wo',
      soundFile: 'sounds/wo.mp3',
      hint: "Whoa! There's a boomerang in his mouth."),
  Kana(
      symbol: 'ん',
      pronounce: 'n',
      soundFile: 'sounds/n.mp3',
      hint: 'ん looks just like n, the lowercase "n".'),
];
