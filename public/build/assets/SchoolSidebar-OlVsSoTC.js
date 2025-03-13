import {
  a,
  g as d,
  k as f,
  x as g,
  t as h,
  o as i,
  l as k,
  u as l,
  F as m,
  f as n,
  w as o,
  r as p,
  P as s,
  b as t,
  h as u,
} from './app-og1a5y7x.js';
const b = {
    class:
      "bg-custom min-h-screen bg-gray-50 bg-[url('/assets/patterns/education-pattern.png')] bg-repeat dark:bg-gray-900",
  },
  M = {
    class:
      'fixed left-0 right-0 top-0 z-50 border-b border-gray-200 bg-white px-4 py-2.5 dark:border-gray-700 dark:bg-gray-800',
  },
  _ = { class: 'flex flex-wrap items-center justify-between' },
  z = { class: 'flex items-center justify-start' },
  B = { class: 'flex items-center lg:order-2' },
  S = {
    class:
      'z-50 my-4 hidden max-w-sm list-none divide-y divide-gray-100 overflow-hidden rounded-xl bg-white text-xs shadow-lg dark:divide-gray-600 dark:bg-gray-700',
    id: 'apps-dropdown',
    'data-popper-placement': 'bottom',
    style: {
      position: 'absolute',
      inset: '0px auto auto 0px',
      margin: '0px',
      transform: 'translate3d(1309.6px, 60.8px, 0px)',
    },
  },
  j = { class: 'grid grid-cols-3 gap-4 p-4' },
  C = {
    class:
      'z-50 my-4 hidden w-56 list-none divide-y divide-gray-100 rounded-xl bg-white text-xs shadow dark:divide-gray-600 dark:bg-gray-700',
    id: 'dropdown',
    'data-popper-placement': 'bottom',
    style: {
      position: 'absolute',
      inset: '0px auto auto 0px',
      margin: '0px',
      transform: 'translate3d(1357.6px, 56.8px, 0px)',
    },
  },
  $ = { class: 'px-4 py-3' },
  L = { class: 'block text-xs font-medium text-gray-900 dark:text-white' },
  H = { class: 'block truncate text-xs text-gray-900 dark:text-white' },
  P = { class: 'py-1 text-gray-700 dark:text-gray-300', 'aria-labelledby': 'dropdown' },
  N = { class: 'py-1 text-gray-700 dark:text-gray-300', 'aria-labelledby': 'dropdown' },
  V = {
    class:
      'fixed left-0 top-0 z-40 h-screen w-64 -translate-x-full border-r border-gray-200 bg-white pt-20 transition-transform dark:border-gray-700 dark:bg-gray-800 md:translate-x-0',
    'aria-label': 'Sidenav',
    id: 'drawer-navigation',
    'aria-hidden': 'true',
  },
  A = { class: '-mt-1 flex h-screen flex-col overflow-hidden pt-16 md:ml-64' },
  D = { class: 'border-gray-200 bg-white' },
  E = { class: 'flex-1 overflow-y-auto' },
  F = {
    mounted() {
      f();
    },
  },
  W = Object.assign(F, {
    __name: 'SchoolLayout',
    setup(c) {
      return (r, e) => (
        i(),
        d('div', b, [
          t('nav', M, [
            t('div', _, [
              t('div', z, [
                e[1] ||
                  (e[1] = g(
                    '<button data-drawer-target="drawer-navigation" data-drawer-toggle="drawer-navigation" aria-controls="drawer-navigation" class="mr-2 cursor-pointer rounded-lg p-2 text-gray-600 hover:bg-gray-100 hover:text-gray-900 focus:bg-gray-100 focus:ring-2 focus:ring-gray-100 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:bg-gray-700 dark:focus:ring-gray-700 md:hidden"><svg aria-hidden="true" class="h-6 w-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg><svg aria-hidden="true" class="hidden h-6 w-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg><span class="sr-only">Toggle sidebar</span></button>',
                    1,
                  )),
                a(
                  l(s),
                  { href: r.route('school'), class: 'mr-4 flex items-center justify-between' },
                  {
                    default: o(
                      () =>
                        e[0] ||
                        (e[0] = [
                          t(
                            'img',
                            { src: '/assets/icons/main-school-logo.png', class: 'mr-3 h-10', alt: 'School Logo' },
                            null,
                            -1,
                          ),
                        ]),
                    ),
                    _: 1,
                  },
                  8,
                  ['href'],
                ),
              ]),
              t('div', B, [
                u('', !0),
                u('', !0),
                u('', !0),
                t('div', S, [
                  e[13] ||
                    (e[13] = t(
                      'div',
                      {
                        class:
                          'block bg-gray-50 px-4 py-2 text-center text-xs font-medium text-gray-800 dark:bg-gray-600 dark:text-gray-300',
                      },
                      ' Apps ',
                      -1,
                    )),
                  t('div', j, [
                    a(
                      l(s),
                      {
                        href: r.route('school'),
                        class: 'group block rounded-lg p-4 text-center hover:bg-gray-100 dark:hover:bg-gray-600',
                      },
                      {
                        default: o(
                          () =>
                            e[11] ||
                            (e[11] = [
                              t(
                                'svg',
                                {
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  viewBox: '0 0 24 24',
                                  fill: 'none',
                                  stroke: 'currentColor',
                                  'stroke-width': '1.5',
                                  'stroke-linecap': 'round',
                                  'stroke-linejoin': 'round',
                                  class:
                                    'mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400',
                                },
                                [
                                  t('path', { stroke: 'none', d: 'M0 0h24v24H0z', fill: 'none' }),
                                  t('path', {
                                    d: 'M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18',
                                  }),
                                  t('path', { d: 'M13 8l2 0' }),
                                  t('path', { d: 'M13 12l2 0' }),
                                ],
                                -1,
                              ),
                              t('div', { class: 'text-xs text-gray-900 dark:text-white' }, 'Staf', -1),
                            ]),
                        ),
                        _: 1,
                      },
                      8,
                      ['href'],
                    ),
                    a(
                      l(s),
                      {
                        href: r.route('school'),
                        class: 'group block rounded-lg p-4 text-center hover:bg-gray-100 dark:hover:bg-gray-600',
                      },
                      {
                        default: o(
                          () =>
                            e[12] ||
                            (e[12] = [
                              t(
                                'svg',
                                {
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  viewBox: '0 0 24 24',
                                  fill: 'none',
                                  stroke: 'currentColor',
                                  'stroke-width': '1.5',
                                  'stroke-linecap': 'round',
                                  'stroke-linejoin': 'round',
                                  class:
                                    'mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400',
                                },
                                [
                                  t('path', { stroke: 'none', d: 'M0 0h24v24H0z', fill: 'none' }),
                                  t('path', { d: 'M22 9l-10 -4l-10 4l10 4l10 -4v6' }),
                                  t('path', { d: 'M6 10.6v5.4a6 3 0 0 0 12 0v-5.4' }),
                                ],
                                -1,
                              ),
                              t('div', { class: 'text-xs text-gray-900 dark:text-white' }, 'Guru', -1),
                            ]),
                        ),
                        _: 1,
                      },
                      8,
                      ['href'],
                    ),
                  ]),
                ]),
                e[16] ||
                  (e[16] = t(
                    'button',
                    {
                      type: 'button',
                      class:
                        'mx-3 flex rounded-full bg-gray-800 text-xs focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600 md:mr-0',
                      id: 'user-menu-button',
                      'aria-expanded': 'false',
                      'data-dropdown-toggle': 'dropdown',
                    },
                    [
                      t('span', { class: 'sr-only' }, 'Open user menu'),
                      t('img', {
                        class: 'h-7 w-7 rounded-full',
                        src: '/assets/icons/user-circle.png',
                        alt: 'user photo',
                      }),
                    ],
                    -1,
                  )),
                t('div', C, [
                  t('div', $, [
                    t('span', L, h(r.$page.props.auth.user.name), 1),
                    t('span', H, h(r.$page.props.auth.user.email), 1),
                  ]),
                  t('ul', P, [
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: '#',
                          class:
                            'block px-4 py-2 text-xs hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white',
                        },
                        { default: o(() => e[14] || (e[14] = [n('Pengaturan Akun')])), _: 1 },
                      ),
                    ]),
                  ]),
                  t('ul', N, [
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('portal'),
                          class:
                            'block px-4 py-2 text-xs hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white',
                        },
                        { default: o(() => e[15] || (e[15] = [n('Keluar Portal')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
          t('aside', V, [p(r.$slots, 'sidebar')]),
          t('main', A, [t('section', D, [p(r.$slots, 'header')]), t('section', E, [p(r.$slots, 'content')])]),
        ])
      );
    },
  }),
  G = { class: 'h-screen overflow-y-auto bg-white px-3 py-1 dark:bg-gray-800' },
  K = { class: 'space-y-2' },
  O = {
    id: 'availableSchoolDropdownButton',
    'data-dropdown-toggle': 'available-school-dropdown',
    class:
      'inline-flex w-full items-center rounded-lg bg-blue-800 px-4 py-3 text-center text-xs font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800',
    type: 'button',
  },
  T = {
    id: 'available-school-dropdown',
    class: 'z-10 hidden w-full divide-y divide-gray-100 rounded-lg bg-white shadow-lg dark:bg-gray-700',
  },
  q = { class: 'py-2 text-xs text-gray-700 dark:text-gray-200', 'aria-labelledby': 'multiLevelDropdownButton' },
  I = { id: 'dropdown-activity', class: 'hidden space-y-2 py-2' },
  J = { id: 'dropdown-management', class: 'hidden space-y-2 py-2' },
  Q = { id: 'dropdown-setting', class: 'hidden space-y-2 py-2' },
  R = {
    mounted() {
      f();
    },
  },
  X = Object.assign(R, {
    __name: 'SchoolSidebar',
    setup(c) {
      return (r, e) => {
        var x, w;
        return (
          i(),
          d('div', null, [
            t('div', G, [
              t('ul', K, [
                t('li', null, [
                  t('button', O, [
                    n(
                      h(
                        (w = (x = r.$page.props.auth.active_school) == null ? void 0 : x.area) == null
                          ? void 0
                          : w.name,
                      ) + ' ',
                      1,
                    ),
                    e[0] ||
                      (e[0] = t(
                        'svg',
                        {
                          class: 'ml-auto h-2.5 w-2.5',
                          'aria-hidden': 'true',
                          xmlns: 'http://www.w3.org/2000/svg',
                          fill: 'none',
                          viewBox: '0 0 10 6',
                        },
                        [
                          t('path', {
                            stroke: 'currentColor',
                            'stroke-linecap': 'round',
                            'stroke-linejoin': 'round',
                            'stroke-width': '2',
                            d: 'm1 1 4 4 4-4',
                          }),
                        ],
                        -1,
                      )),
                  ]),
                  t('div', T, [
                    t('ul', q, [
                      (i(!0),
                      d(
                        m,
                        null,
                        k(
                          r.$page.props.auth.available_schools,
                          (v, y) => (
                            i(),
                            d('li', { key: y }, [
                              a(
                                l(s),
                                {
                                  href: r.route('school.switchActiveSchool', { active_school_id: v.uuid }),
                                  class:
                                    'block px-4 py-2.5 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white',
                                },
                                { default: o(() => [n(h(v.area.name), 1)]), _: 2 },
                                1032,
                                ['href'],
                              ),
                            ])
                          ),
                        ),
                        128,
                      )),
                    ]),
                  ]),
                ]),
                t('li', null, [
                  a(
                    l(s),
                    {
                      href: r.route('school.student'),
                      class:
                        'group flex items-center rounded-lg p-2 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                    },
                    {
                      default: o(
                        () =>
                          e[1] ||
                          (e[1] = [
                            t(
                              'svg',
                              {
                                xmlns: 'http://www.w3.org/2000/svg',
                                viewBox: '0 0 24 24',
                                fill: 'none',
                                stroke: 'currentColor',
                                'stroke-width': '1.5',
                                'stroke-linecap': 'round',
                                'stroke-linejoin': 'round',
                                class:
                                  'h-6 w-6 flex-shrink-0 text-gray-700 transition duration-75 group-hover:text-gray-800 dark:text-gray-500 dark:group-hover:text-white',
                              },
                              [
                                t('path', { stroke: 'none', d: 'M0 0h24v24H0z', fill: 'none' }),
                                t('path', { d: 'M10 13a2 2 0 1 0 4 0a2 2 0 0 0 -4 0' }),
                                t('path', { d: 'M8 21v-1a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v1' }),
                                t('path', { d: 'M15 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0' }),
                                t('path', { d: 'M17 10h2a2 2 0 0 1 2 2v1' }),
                                t('path', { d: 'M5 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0' }),
                                t('path', { d: 'M3 13v-1a2 2 0 0 1 2 -2h2' }),
                              ],
                              -1,
                            ),
                            t('span', { class: 'ml-3 flex-1 whitespace-nowrap' }, 'Siswa', -1),
                          ]),
                      ),
                      _: 1,
                    },
                    8,
                    ['href'],
                  ),
                ]),
                t('li', null, [
                  e[3] ||
                    (e[3] = g(
                      '<button type="button" class="group flex w-full items-center rounded-lg p-2 text-xs font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="dropdown-activity" data-collapse-toggle="dropdown-activity"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="h-6 w-6 flex-shrink-0 text-gray-700 transition duration-75 group-hover:text-gray-800 dark:text-gray-500 dark:group-hover:text-white"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18"></path><path d="M13 8l2 0"></path><path d="M13 12l2 0"></path></svg><span class="ml-3 flex-1 whitespace-nowrap text-left">Aktifitas</span><svg aria-hidden="true" class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg></button>',
                      1,
                    )),
                  t('ul', I, [
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.activity.admissionStudent'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[2] || (e[2] = [n('Pendaftaran Siswa Baru')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                  ]),
                ]),
                t('li', null, [
                  e[9] ||
                    (e[9] = g(
                      '<button type="button" class="group flex w-full items-center rounded-lg p-2 text-xs font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="dropdown-management" data-collapse-toggle="dropdown-management"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="h-6 w-6 flex-shrink-0 text-gray-700 transition duration-75 group-hover:text-gray-800 dark:text-gray-500 dark:group-hover:text-white"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M3 4m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v0a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z"></path><path d="M5 8v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-10"></path><path d="M10 12l4 0"></path></svg><span class="ml-3 flex-1 whitespace-nowrap text-left">Pengelolaan</span><svg aria-hidden="true" class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg></button>',
                      1,
                    )),
                  t('ul', J, [
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.management.schoolSubjectGroup'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[4] || (e[4] = [n('Grup Mata Pelajaran')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.management.schoolSubject'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[5] || (e[5] = [n('Mata Pelajaran')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.management.schoolClassroom'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[6] || (e[6] = [n('Kelas')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.management.schoolExtracurricular'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[7] || (e[7] = [n('Ekstrakurikuler')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: r.route('school.management.schoolClub'),
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[8] || (e[8] = [n('Klub')])), _: 1 },
                        8,
                        ['href'],
                      ),
                    ]),
                  ]),
                ]),
                t('li', null, [
                  e[11] ||
                    (e[11] = g(
                      '<button type="button" class="group flex w-full items-center rounded-lg p-2 text-xs font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="dropdown-setting" data-collapse-toggle="dropdown-setting"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="h-6 w-6 flex-shrink-0 text-gray-700 transition duration-75 group-hover:text-gray-800 dark:text-gray-500 dark:group-hover:text-white"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12.003 21c-.732 .001 -1.465 -.438 -1.678 -1.317a1.724 1.724 0 0 0 -2.573 -1.066c-1.543 .94 -3.31 -.826 -2.37 -2.37a1.724 1.724 0 0 0 -1.065 -2.572c-1.756 -.426 -1.756 -2.924 0 -3.35a1.724 1.724 0 0 0 1.066 -2.573c-.94 -1.543 .826 -3.31 2.37 -2.37c1 .608 2.296 .07 2.572 -1.065c.426 -1.756 2.924 -1.756 3.35 0a1.724 1.724 0 0 0 2.573 1.066c1.543 -.94 3.31 .826 2.37 2.37a1.724 1.724 0 0 0 1.065 2.572c.886 .215 1.325 .957 1.318 1.694"></path><path d="M9 12a3 3 0 1 0 6 0a3 3 0 0 0 -6 0"></path><path d="M19.001 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0"></path><path d="M19.001 15.5v1.5"></path><path d="M19.001 21v1.5"></path><path d="M22.032 17.25l-1.299 .75"></path><path d="M17.27 20l-1.3 .75"></path><path d="M15.97 17.25l1.3 .75"></path><path d="M20.733 20l1.3 .75"></path></svg><span class="ml-3 flex-1 whitespace-nowrap text-left">Pengaturan</span><svg aria-hidden="true" class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg></button>',
                      1,
                    )),
                  t('ul', Q, [
                    t('li', null, [
                      a(
                        l(s),
                        {
                          href: '#',
                          class:
                            'group flex w-full items-center rounded-lg p-2 pl-11 text-xs font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700',
                        },
                        { default: o(() => e[10] || (e[10] = [n('Sekolah')])), _: 1 },
                      ),
                    ]),
                  ]),
                ]),
              ]),
              u('', !0),
            ]),
          ])
        );
      };
    },
  });
export { X as _, W as a };
