class SlideData {
  final String title;
  final String subtitle;
  final List<String> bulletPoints;
  final Map<String, String>? statistics;
  final List<String>? caseStudies;
  final SlideType type;
  final String? backgroundImage;
  final List<SourceLink>? sourceLinks;
  final List<String>? speakingNotes;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.bulletPoints,
    this.statistics,
    this.caseStudies,
    required this.type,
    this.backgroundImage,
    this.sourceLinks,
    this.speakingNotes,
  });
}

class SourceLink {
  final String title;
  final String url;
  final String description;

  SourceLink({
    required this.title,
    required this.url,
    required this.description,
  });
}

enum SlideType {
  title,
  statistics,
  performance,
  roi,
  future,
  partnership,
  interactive,
  conclusion,
  showcase,
}

class PresentationData {
  static List<SlideData> getSlides() {
    return [
      SlideData(
        title: "Flutter: The Strategic Choice",
        subtitle: "Cross-Platform Development Excellence",
        bulletPoints: [
          "Market-leading framework with proven enterprise adoption",
          "Superior performance and technical architecture",
          "Measurable ROI and business impact",
        ],
        type: SlideType.title,
        sourceLinks: [
          SourceLink(
            title: "Flutter Official Website",
            url: "https://flutter.dev",
            description: "Official Flutter documentation and resources",
          ),
          SourceLink(
            title: "Google I/O 2025 Flutter Updates",
            url: "https://io.google/2025/explore/pa-keynote-12",
            description: "Latest Flutter announcements and roadmap",
          ),
        ],
        speakingNotes: [
          "Welcome everyone to this presentation on Flutter as the strategic choice for cross-platform development.",
          "Today I'll be showing you why Flutter has become the leading framework for enterprise mobile development.",
          "We'll cover three key areas: market leadership, technical superiority, and measurable business impact.",
          "By the end of this presentation, you'll understand why 95.7% of CTOs would choose Flutter again for their next project.",
        ],
      ),
      SlideData(
        title: "Market Leadership & Momentum",
        subtitle: "Flutter Dominates 2025 Cross-Platform Landscape",
        bulletPoints: [
          "46% global market share vs React Native's 32%",
          "170k GitHub stars vs React Native's 121k",
          "64% developer satisfaction (highest among frameworks)",
          "30% of all new iOS apps built with Flutter",
        ],
        statistics: {
          "Market Share": "46%",
          "GitHub Stars": "170k",
          "Developer Satisfaction": "64%",
          "New iOS Apps": "30%",
        },
        type: SlideType.statistics,
        sourceLinks: [
          SourceLink(
            title: "Stack Overflow Developer Survey 2024",
            url: "https://survey.stackoverflow.co/2024/",
            description: "Annual developer satisfaction and usage statistics",
          ),
          SourceLink(
            title: "GitHub Flutter Repository",
            url: "https://github.com/flutter/flutter",
            description: "Official Flutter GitHub repository with star count",
          ),
          SourceLink(
            title: "Statista Mobile Framework Report 2024",
            url:
                "https://www.statista.com/statistics/869224/worldwide-software-developer-working-hours/",
            description: "Cross-platform framework market share analysis",
          ),
        ],
        speakingNotes: [
          "Let's start with the numbers that matter. Flutter has achieved a commanding 46% market share in cross-platform development.",
          "This represents a 14-point lead over React Native, which sits at 32%. This isn't just a small advantage - it's market dominance.",
          "The GitHub community shows strong support with 170k stars, significantly ahead of React Native's 121k.",
          "Most importantly, developers love working with Flutter - 64% satisfaction rate is the highest among all cross-platform frameworks.",
          "Perhaps most telling: 30% of all new iOS apps are now being built with Flutter, showing real enterprise adoption.",
        ],
      ),
      SlideData(
        title: "Enterprise Success Stories",
        subtitle: "Proven at Scale by Industry Leaders",
        bulletPoints: [
          "BMW: Global deployment across 47 countries",
          "Alibaba Xianyu: 50M+ users, 50% faster development",
          "Headspace: Mental wellness app with millions of daily users",
          "eBay Motors: 98.3% code sharing, 2x development speed",
          "Toyota: Mission-critical automotive systems",
        ],
        type: SlideType.interactive,
        sourceLinks: [
          SourceLink(
            title: "BMW Flutter Case Study",
            url: "https://flutter.dev/showcase/bmw",
            description: "How BMW uses Flutter for global automotive apps",
          ),
          SourceLink(
            title: "Alibaba Xianyu Success Story",
            url: "https://flutter.dev/showcase/alibaba-group",
            description: "Alibaba's 50M+ user Flutter implementation",
          ),
          SourceLink(
            title: "Headspace Flutter Implementation",
            url: "https://flutter.dev/showcase/headspace",
            description:
                "How Headspace built their meditation app with Flutter",
          ),
          SourceLink(
            title: "eBay Motors Technical Blog",
            url: "https://flutter.dev/showcase/ebay",
            description: "Technical deep dive into eBay's Flutter adoption",
          ),
        ],
        speakingNotes: [
          "These aren't small startups - these are global industry leaders proving Flutter works at enterprise scale.",
          "BMW deployed Flutter across 47 countries with a single codebase, managing their global automotive app ecosystem.",
          "Alibaba's Xianyu marketplace serves over 50 million users with 50% faster feature development cycles.",
          "Headspace chose Flutter to deliver their mental wellness platform to millions of daily users across all platforms with consistent, beautiful animations.",
          "eBay Motors achieved 98.3% code sharing and doubled their development speed compared to native development.",
          "Toyota's adoption for automotive systems proves Flutter's reliability in mission-critical applications.",
        ],
      ),
      SlideData(
        title: "Technical & Performance Excellence",
        subtitle: "Built for Speed, Scalability & Multi-Platform Success",
        bulletPoints: [
          "2x faster startup (2s vs 4-10s), 60 FPS consistency",
          "Custom rendering engine eliminates JavaScript bridge",
          "18% better battery efficiency, 50% lower CPU usage",
          "Single codebase deploys to 6+ platforms seamlessly",
        ],
        statistics: {
          "Startup Time": "2x faster",
          "Frame Rate": "60 FPS",
          "Battery Efficiency": "18% better",
          "CPU Usage": "50% lower",
        },
        type: SlideType.performance,
        sourceLinks: [
          SourceLink(
            title: "Flutter Performance Best Practices",
            url: "https://docs.flutter.dev/perf/best-practices",
            description: "Official Flutter performance optimization guide",
          ),
          SourceLink(
            title: "Flutter Architecture Overview",
            url: "https://docs.flutter.dev/resources/architectural-overview",
            description: "Technical deep dive into Flutter's architecture",
          ),
          SourceLink(
            title: "Flutter vs React Native Performance Study",
            url:
                "https://nateshmbhat.medium.com/flutter-vs-react-native-performance-benchmarks-you-cant-miss-%EF%B8%8F-2e31905df9b4",
            description: "Comprehensive performance benchmarking analysis",
          ),
        ],
        speakingNotes: [
          "Flutter's technical architecture delivers measurable performance advantages that directly impact user experience and business outcomes.",
          "Apps start in 2 seconds vs 4-10 seconds for other frameworks, with consistent 60 FPS performance thanks to the custom rendering engine.",
          "The ahead-of-time compilation eliminates JavaScript bridge bottlenecks, resulting in 18% better battery efficiency and 50% lower CPU usage.",
          "This superior architecture enables true write-once, deploy-everywhere functionality across 6+ platforms from a single codebase.",
        ],
      ),
      SlideData(
        title: "Superior Developer Experience",
        subtitle: "World-Class Tooling & Ecosystem",
        bulletPoints: [
          "Flutter CLI: Hot reload, debugging, and deployment in one tool",
          "Dart compiler: Ahead-of-time compilation with tree shaking",
          "pub.dev: 45k+ packages with quality scoring and verification",
          "Package labels ensure vetted, maintained libraries rise to top",
        ],
        statistics: {
          "Available Packages": "45k+",
          "Quality Scoring": "Automated",
          "Hot Reload": "<1 second",
          "Quality SDKs": "Top providers",
          "CLI Commands": "50+",
        },
        type: SlideType.performance,
        sourceLinks: [
          SourceLink(
            title: "Flutter Command Line Tools",
            url: "https://docs.flutter.dev/reference/flutter-cli",
            description:
                "Complete reference for Flutter CLI commands and tooling",
          ),
          SourceLink(
            title: "pub.dev Package Repository",
            url: "https://pub.dev",
            description:
                "Official Dart and Flutter package repository with quality metrics",
          ),
          SourceLink(
            title: "Dart Compilation and Performance",
            url: "https://dart.dev/tools/dart-compile",
            description: "Technical overview of Dart's compilation advantages",
          ),
        ],
        speakingNotes: [
          "Flutter's developer experience is unmatched in the cross-platform space, starting with the comprehensive CLI tooling.",
          "The Flutter CLI provides everything from hot reload in under 1 second to complete deployment pipelines, all integrated seamlessly.",
          "Dart's ahead-of-time compilation with tree shaking eliminates unused code, resulting in smaller, faster apps.",
          "The pub.dev ecosystem hosts over 45,000 packages with automated quality scoring and verification badges.",
          "Package labels like 'Flutter Favorite' and 'Verified Publisher' ensure that high-quality, well-maintained libraries are easily discoverable and rise to the top of search results.",
        ],
      ),
      SlideData(
        title: "Quality Through Comprehensive Testing",
        subtitle: "Flutter's Built-in Quality Assurance Excellence",
        bulletPoints: [
          "Three-tier testing: Unit, Widget, and Integration tests",
          "Golden file testing for pixel-perfect UI validation",
          "95%+ test coverage achievable with built-in tools",
          "Automated CI/CD integration with comprehensive reporting",
        ],
        statistics: {
          "Test Types": "3 tiers",
          "Coverage Achievable": "95%+",
          "CI/CD Integration": "Built-in",
          "Testing Speed": "Milliseconds",
        },
        type: SlideType.performance,
        sourceLinks: [
          SourceLink(
            title: "Flutter Testing Documentation",
            url: "https://docs.flutter.dev/testing",
            description: "Comprehensive guide to Flutter's testing framework",
          ),
        ],
        speakingNotes: [
          "Flutter's testing framework is one of its strongest quality assurance features, built into the core framework rather than added as an afterthought.",
          "The three-tier testing approach covers unit tests for business logic, widget tests for UI components, and integration tests for complete user flows.",
          "Teams regularly achieve 95%+ test coverage using Flutter's built-in tools, with tests running in milliseconds for rapid feedback cycles.",
          "The framework integrates seamlessly with CI/CD pipelines, providing comprehensive test reporting and quality gates.",
        ],
      ),
      SlideData(
        title: "Proven ROI & Business Impact",
        subtitle: "Real Numbers from Real Enterprise Implementations",
        bulletPoints: [
          "50-77% faster development cycles",
          "2-3x faster MVP development",
          "30-50% cost savings in initial development",
          "15-20% ongoing maintenance reduction",
        ],
        statistics: {
          "Development Speed": "50-77% faster",
          "MVP Development": "2-3x faster",
          "Cost Savings": "30-50%",
          "Maintenance": "15-20% less",
        },
        type: SlideType.roi,
        sourceLinks: [
          SourceLink(
            title: "Enterprise Flutter Adoption Report",
            url: "https://flutter.dev/showcase",
            description: "Real-world enterprise Flutter success stories",
          ),
          SourceLink(
            title: "Flutter in production",
            url: "https://flutter.dev/events/flutter-in-production",
            description: "Google I/O 2025 Flutter in production",
          ),
          SourceLink(
            title: "CTO report",
            url: "https://leancode.co/report/flutter-cto-report",
            description: "CTO report on Flutter adoption and satisfaction",
          ),
        ],
        speakingNotes: [
          "Now let's talk about the bottom line - return on investment. These aren't theoretical numbers, they're from real enterprise implementations.",
          "Development cycles are 50-77% faster because you're writing one codebase instead of separate iOS and Android apps.",
          "For MVP development, teams see 2-3x speed improvement, getting to market faster than competitors.",
          "Initial development costs are reduced by 30-50% - that's significant budget savings that can be reinvested elsewhere.",
          "Ongoing maintenance is 15-20% less expensive because you're maintaining one codebase instead of multiple platform-specific codebases.",
        ],
      ),
      SlideData(
        title: "Future-Ready Platform",
        subtitle: "AI Integration & Emerging Technologies",
        bulletPoints: [
          "Native AI integration in <50 lines of code",
          "WebAssembly support for high-performance web",
          "Desktop, mobile, web deployment from single codebase",
          "Continuously evolving with Google's innovation pipeline",
        ],
        type: SlideType.future,
        sourceLinks: [
          SourceLink(
            title: "Flutter AI Integration Guide",
            url: "https://ai.google.dev/gemini-api/docs/flutter",
            description: "Official guide for integrating AI into Flutter apps",
          ),
          SourceLink(
            title: "Flutter Web and WASM Support",
            url: "https://docs.flutter.dev/platform-integration/web/wasm",
            description: "WebAssembly support in Flutter for web performance",
          ),
          SourceLink(
            title: "Flutter Roadmap 2025",
            url:
                "https://github.com/flutter/flutter/blob/master/docs/roadmap/Roadmap.md",
            description:
                "Official Flutter development roadmap and future plans",
          ),
          SourceLink(
            title: "New Flutter Features",
            url:
                "https://medium.com/flutter/dart-flutter-momentum-at-google-i-o-2025-4863aa4f84a4",
            description: "BLog post on Flutter features and updates",
          ),
        ],
      ),
      SlideData(
        title: "The Strategic Decision",
        subtitle: "Flutter = Complete Development Excellence",
        bulletPoints: [
          "Superior DX: World-class tooling, 45k+ vetted packages, <1s hot reload",
          "Quality Assurance: Built-in 3-tier testing, 95%+ coverage achievable",
          "Performance & ROI: 2-3x faster development, 30-50% cost savings",
          "Future-Ready: AI integration, multi-platform deployment, proven at scale",
        ],
        type: SlideType.conclusion,
        sourceLinks: [
          SourceLink(
            title: "CTO Survey: Flutter Satisfaction",
            url: "https://leancode.co/report/flutter-cto-report",
            description: "Industry survey on Flutter adoption and satisfaction",
          ),
          SourceLink(
            title: "Flutter Business Case Template",
            url: "https://flutter.dev/multi-platform",
            description: "Resources for building a business case for Flutter",
          ),
          SourceLink(
            title: "Getting Started with Flutter",
            url: "https://docs.flutter.dev/get-started",
            description: "Official Flutter getting started guide",
          ),
        ],
        speakingNotes: [
          "Flutter delivers complete development excellence across every dimension that matters to your business.",
          "Developer experience is unmatched: world-class CLI tooling, 45,000+ quality-verified packages, and hot reload in under 1 second.",
          "Quality is built-in, not bolted-on: comprehensive 3-tier testing framework with 95%+ coverage achievable out of the box.",
          "The business case is compelling: 2-3x faster development cycles and 30-50% cost savings from day one.",
          "You're future-proofed: AI integration capabilities, true multi-platform deployment, and proven success at enterprise scale.",
          "This isn't just a technology choice - it's a strategic advantage that 95.7% of CTOs would choose again.",
        ],
      ),
      SlideData(
        title: "Explore More Success Stories",
        subtitle: "Discover How Companies Around the World Use Flutter",
        bulletPoints: [
          "See real-world implementations from industry leaders",
          "Explore case studies and technical deep-dives",
          "Learn from companies who've scaled Flutter globally",
          "Get inspired by innovative Flutter applications",
          "! This presentation was created using Flutter !",
        ],
        type: SlideType.showcase,
        sourceLinks: [
          SourceLink(
            title: "Flutter Showcase",
            url: "https://flutter.dev/showcase",
            description:
                "Official Flutter showcase featuring success stories from companies worldwide",
          ),
          SourceLink(
            title: "Flutter Case Studies",
            url: "https://flutter.dev/showcase#case-studies",
            description:
                "In-depth case studies showing how companies built their Flutter apps",
          ),
          SourceLink(
            title: "Flutter Customer Stories",
            url: "https://flutter.dev/showcase#customer-stories",
            description:
                "Direct testimonials and stories from Flutter customers",
          ),
        ],
        speakingNotes: [
          "Before we wrap up, I want to leave you with resources to explore further.",
          "The Flutter showcase website features hundreds of real-world success stories from companies just like yours.",
          "You'll find detailed case studies showing exactly how companies implemented Flutter and what results they achieved.",
          "From startups to Fortune 500 companies, these stories prove that Flutter works at any scale.",
          "Visit flutter.dev/showcase to see what's possible when you choose Flutter for your next project.",
        ],
      ),
    ];
  }
}
