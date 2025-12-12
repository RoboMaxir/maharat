/// موتور مربی هوشمند
/// این موتور پاسخ به سوالات رایج فریلنسری را با پایگاه دانش محلی ارائه می‌دهد
class SmartMentorEngine {
  // پایگاه دانش محلی برای سوالات رایج فریلنسری ایران
  static const Map<String, List<Map<String, String>>> _knowledgeBase = {
    'pricing': [
      {
        'question_pattern': 'چطور قیمت پروژه خود را تعیین کنم؟',
        'answer': 'برای تعیین قیمت پروژه، باید چند عامل را در نظر بگیرید:\n1. زمان لازم برای انجام کار\n2. سطح تخصص لازم\n3. پیچیدگی پروژه\n4. بازار ایران (نرخ‌های رایج در حوزه شما)\n5. سابقه کارفرما\nهمیشه حداقل ۲۰-۳۰٪ پیش‌پرداخت دریافت کنید.',
        'tags': ['price', 'estimation', 'rate']
      },
      {
        'question_pattern': 'نرخ روزانه من چقدر باید باشد؟',
        'answer': 'نرخ روزانه در ایران بسته به حوزه کاری متفاوت است:\n- توسعه وب: ۵۰۰,۰۰۰ تا ۲,۰۰۰,۰۰۰ تومان\n- طراحی گرافیک: ۳۰۰,۰۰۰ تا ۱,۰۰۰,۰۰۰ تومان\n- نوشتار محتوا: ۲۰۰,۰۰۰ تا ۸۰۰,۰۰۰ تومان\n- توسعه اپلیکیشن: ۸۰۰,۰۰۰ تا ۳,۰۰۰,۰۰۰ تومان\nاین نرخ‌ها بسته به تجربه و شهرت شما قابل افزایش است.',
        'tags': ['daily_rate', 'hourly', 'salary']
      }
    ],
    'contracts': [
      {
        'question_pattern': 'چه چیزهایی باید در قرارداد فریلنسری باشد؟',
        'answer': 'قرارداد فریلنسری باید شامل موارد زیر باشد:\n1. محدوده کار (Scope of Work)\n2. زمان تحویل\n3. نحوه پرداخت (پیش‌پرداخت، پس‌پرداخت)\n4. حق تغییرات پروژه\n5. مالکیت معنوی\n6. حریم خصوصی\n7. جریمه تاخیر\nهمیشه یک قرارداد کتبی داشته باشید!',
        'tags': ['contract', 'agreement', 'terms']
      },
      {
        'question_pattern': 'آیا باید قرارداد بنویسم؟',
        'answer': ' absolutely بله! هر پروژه نیاز به قرارداد رسمی دارد.\nحتی برای کارهای کوچک، حداقل یک توافق کتبی ساده ایجاد کنید.\nقرارداد از شما و کارفرما محافظت می‌کند و از سوءتفاهم جلوگیری می‌کند.',
        'tags': ['contract', 'agreement', 'necessity']
      }
    ],
    'client_management': [
      {
        'question_pattern': 'چطور با کارفرمای دشوار کار کنم؟',
        'answer': 'برای مدیریت کارفرمای دشوار:\n1. همیشه یک قرارداد شفاف داشته باشید\n2. تغییرات را جداگانه پیگیری کنید\n3. ارتباطات را کتبی نگه دارید\n4. اهداف و محدوده را مشخص کنید\n5. در صورت نیاز، پروژه را متوقف کنید\nهمیشه احترام بگذارید اما مرزها را رعایت کنید.',
        'tags': ['difficult_client', 'management', 'boundaries']
      },
      {
        'question_pattern': 'کارفرما مدام تغییرات می‌دهد چیکار کنم؟',
        'answer': 'برای کنترل تغییرات:\n1. در قرارداد محدودیت تغییرات را مشخص کنید\n2. هر تغییر اضافی را جداگانه قیمت‌گذاری کنید\n3. همه درخواست‌ها را کتبی ثبت کنید\n4. اگر تغییرات بیش از حد باشد، از کار انصراف دهید\nتغییرات بی‌پایان سودی برای شما ندارد.',
        'tags': ['scope_creep', 'changes', 'modifications']
      }
    ],
    'marketing': [
      {
        'question_pattern': 'چطور پورتفولیوم را بهتر کنم؟',
        'answer': 'برای بهبود پورتفولیو:\n1. بهترین پروژه‌های خود را نمایش دهید\n2. قبل و بعد تصویر از کارها ارائه دهید\n3. نظرات مشتریان را بیاورید\n4. توضیح کوتاهی درباره هر پروژه بنویسید\n5. پورتفولیو را منظم و آسان برای مرور کنید\nهمچنین نمونه کار رایگان ندهید!',
        'tags': ['portfolio', 'samples', 'showcase']
      },
      {
        'question_pattern': 'چطور مشتری پیدا کنم؟',
        'answer': 'راه‌های پیدا کردن مشتری:\n1. شبکه‌های اجتماعی (اینستاگرام، لینکدین فارسی)\n2. سایت‌های فریلنسری داخلی\n3. ارتباطات شخصی\n4. ارائه نمونه کار (نه نمونه رایگان!)\n5. شرکت در گروه‌های تخصصی\n6. سایت شخصی حرفه‌ای\nهمیشه کیفیت را بر کمیت ترجیح دهید.',
        'tags': ['clients', 'marketing', 'networking']
      }
    ],
    'technical': [
      {
        'question_pattern': 'چطور پروژه را سازماندهی کنم؟',
        'answer': 'برای سازماندهی پروژه:\n1. از ابزارهای مدیریت پروژه استفاده کنید (مثل Trello، Notion)\n2. پروژه را به بخش‌های کوچک تقسیم کنید\n3. مهلت‌های مشخص تعیین کنید\n4. هر مرحله را مستند کنید\n5. نسخه‌های پشتیبان تهیه کنید\n6. ارتباطات را ثبت کنید\nسازماندهی کلید موفقیت در فریلنسری است.',
        'tags': ['organization', 'project_management', 'planning']
      }
    ]
  };

  /// جستجوی هوشمند در پایگاه دانش بر اساس سوال کاربر
  /// 
  /// [question]: سوال کاربر
  /// [category]: دسته‌بندی مورد نظر (اختیاری)
  /// [userExperience]: سطح تجربه کاربر (1-5)
  Map<String, dynamic>? findAnswer({
    required String question,
    String? category,
    int userExperience = 3,
  }) {
    // اگر دسته مشخص شده باشد، فقط در آن دسته جستجو کن
    Iterable<String> categoriesToSearch = category != null 
        ? [category] 
        : _knowledgeBase.keys;
    
    // جستجوی ساده در میان الگوهای سوال
    for (String cat in categoriesToSearch) {
      List<Map<String, String>> questions = _knowledgeBase[cat]!;
      
      for (Map<String, String> qa in questions) {
        // جستجوی ساده با تطبیق کلمات
        if (_simpleMatch(question, qa['question_pattern']!)) {
          return {
            'question': question,
            'matched_question': qa['question_pattern'],
            'answer': _adjustAnswerForExperience(qa['answer']!, userExperience),
            'category': cat,
            'confidence': 0.9,
            'related_topics': _findRelatedTopics(cat, qa['tags']!),
          };
        }
      }
    }
    
    // اگر نتیجه‌ای پیدا نشد، جستجوی پیشرفته‌تر
    Map<String, dynamic>? bestMatch = _advancedSearch(question, categoriesToSearch);
    
    return bestMatch;
  }
  
  /// تطبیق ساده بین سوال کاربر و الگوهای موجود
  bool _simpleMatch(String userQuestion, String pattern) {
    String lowerUserQ = userQuestion.toLowerCase();
    String lowerPattern = pattern.toLowerCase();
    
    // بررسی تطبیق کامل
    if (lowerUserQ.contains(lowerPattern) || lowerPattern.contains(lowerUserQ)) {
      return true;
    }
    
    // بررسی تطبیق کلمات کلیدی
    List<String> userWords = lowerUserQ.split(RegExp(r'\s+'));
    List<String> patternWords = lowerPattern.split(RegExp(r'\s+'));
    
    int matchingWords = 0;
    for (String word in userWords) {
      if (patternWords.any((pw) => pw.contains(word) || word.contains(pw))) {
        matchingWords++;
      }
    }
    
    // اگر بیش از ۶۰٪ کلمات تطبیق داشتند
    return matchingWords / userWords.length > 0.6;
  }
  
  /// جستجوی پیشرفته برای پیدا کردن پاسخ مناسب
  Map<String, dynamic>? _advancedSearch(String question, Iterable<String> categories) {
    double bestScore = 0.0;
    Map<String, dynamic>? bestMatch;
    
    for (String cat in categories) {
      List<Map<String, String>> questions = _knowledgeBase[cat]!;
      
      for (Map<String, String> qa in questions) {
        double score = _calculateSimilarity(question, qa['question_pattern']!);
        
        if (score > bestScore && score > 0.3) { // حداقل شباهت ۳۰٪
          bestScore = score;
          bestMatch = {
            'question': question,
            'matched_question': qa['question_pattern'],
            'answer': qa['answer'],
            'category': cat,
            'confidence': score,
            'related_topics': _findRelatedTopics(cat, qa['tags']!),
          };
        }
      }
    }
    
    return bestMatch;
  }
  
  /// محاسبه شباهت بین دو متن
  double _calculateSimilarity(String text1, String text2) {
    // الگوریتم ساده‌شده برای محاسبه شباهت
    Set<String> words1 = text1.toLowerCase().split(RegExp(r'\W+')).toSet();
    Set<String> words2 = text2.toLowerCase().split(RegExp(r'\W+')).toSet();
    
    Set<String> intersection = words1.intersection(words2);
    Set<String> union = words1.union(words2);
    
    if (union.isEmpty) return 0.0;
    
    return intersection.length / union.length;
  }
  
  /// تنظیم پاسخ بر اساس سطح تجربه کاربر
  String _adjustAnswerForExperience(String originalAnswer, int experienceLevel) {
    if (experienceLevel <= 2) {
      // برای مبتدیان، توضیحات بیشتر و مراحل ساده‌تر
      return originalAnswer + '\n\nنکته برای مبتدیان: این فرآیند ممکن است چالش‌برانگیز به نظر برسد، اما با تمرین بهبود می‌یابد. می‌توانید از الگوهای موجود در سایت‌های فریلنسری نیز کمک بگیرید.';
    } else if (experienceLevel >= 4) {
      // برای متخصصان، جزئیات بیشتر و موارد پیشرفته
      return originalAnswer + '\n\nنکته برای متخصصان: در نظر داشته باشید که این فقط یک روش است. در پروژه‌های پیچیده، ممکن است نیاز به روش‌های سفارشی‌تری داشته باشید.';
    }
    return originalAnswer; // برای سطوح متوسط، بدون تغییر
  }
  
  /// یافتن موضوعات مرتبط
  List<String> _findRelatedTopics(String category, List<String> tags) {
    List<String> related = [];
    
    // یافتن سایر سوالات با تگ‌های مشابه
    for (String cat in _knowledgeBase.keys) {
      if (cat != category) {
        List<Map<String, String>> questions = _knowledgeBase[cat]!;
        for (Map<String, String> qa in questions) {
          List<String> qTags = qa['tags']!.cast<String>();
          if (qTags.any((tag) => tags.contains(tag))) {
            related.add(qa['question_pattern']!);
          }
        }
      }
    }
    
    return related.take(3).toList(); // حداکثر ۳ موضوع مرتبط
  }
  
  /// ارائه پیشنهادات آموزشی بر اساس سوالات متداول
  List<String> getLearningSuggestions({
    required String currentTopic,
    int userExperience = 3,
  }) {
    List<String> suggestions = [];
    
    // بر اساس موضوع فعلی، پیشنهادات مرتبط ارائه بده
    switch (currentTopic.toLowerCase()) {
      case 'pricing':
        suggestions.addAll([
          'نحوه مذاکره قیمت با کارفرما',
          'محاسبه نرخ ساعتی منصفانه',
          'روش‌های دریافت پیش‌پرداخت'
        ]);
        break;
      case 'contracts':
        suggestions.addAll([
          'قالب قرارداد فریلنسری',
          'موارد حقوقی در قرارداد',
          'نحوه مقابله با کارفرمایان نامجاز'
        ]);
        break;
      case 'client_management':
        suggestions.addAll([
          'مدیریت انتظارات کارفرما',
          'روش‌های ارتباط مؤثر با کارفرما',
          'چگونه پروژه را به موقع تحویل دهیم'
        ]);
        break;
      default:
        suggestions.addAll([
          'مبانی فریلنسری در ایران',
          'نحوه ایجاد پورتفولیو قوی',
          'مدیریت زمان در پروژه‌های چندگانه'
        ]);
    }
    
    // تنظیم پیشنهادات بر اساس سطح تجربه
    if (userExperience <= 2) {
      suggestions.insert(0, 'آموزش مقدماتی فریلنسری');
    } else if (userExperience >= 4) {
      suggestions.add('روش‌های پیشرفته بازاریابی فریلنسری');
    }
    
    return suggestions.take(5).toList(); // حداکثر ۵ پیشنهاد
  }
}

// نمونه استفاده از موتور مربی هوشمند
class SmartMentorExample {
  static void demonstrateSmartMentorEngine() {
    final engine = SmartMentorEngine();
    
    print('\n=== نمونه کاربرد موتور مربی هوشمند ===');
    
    // جستجوی پاسخ برای یک سوال رایج
    var answer = engine.findAnswer(
      question: 'چطور قیمت پروژه خود را تعیین کنم؟',
      userExperience: 3,
    );
    
    if (answer != null) {
      print('پرسش: ${answer['question']}');
      print('دسته: ${answer['category']}');
      print('پاسخ:');
      print(answer['answer']);
      print('اطمینان: ${(answer['confidence'] as double).toStringAsFixed(1)}%');
      
      print('\nموضوعات مرتبط:');
      for (var topic in answer['related_topics']) {
        print('- $topic');
      }
      
      // دریافت پیشنهادات آموزشی
      var suggestions = engine.getLearningSuggestions(
        currentTopic: answer['category'],
        userExperience: 3,
      );
      
      print('\nپیشنهادات آموزشی:');
      for (var suggestion in suggestions) {
        print('- $suggestion');
      }
    } else {
      print('پاسخی برای سوال شما یافت نشد.');
    }
  }
}