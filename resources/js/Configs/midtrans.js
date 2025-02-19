const midtrans = {
    init() {
        return new Promise((resolve, reject) => {
            let js = 'https://app.sandbox.midtrans.com/snap/snap.js';
            let clientKey = import.meta.env.VITE_MIDTRANS_CLIENT_KEY;

            if (import.meta.env.VITE_APP_ENV === 'production') {
                js = 'https://app.midtrans.com/snap/snap.js';
            }

            if (document.querySelector(`script[src="${js}"]`)) {
                resolve();
                return;
            }

            const el = document.createElement('script');
            el.src = js;
            el.setAttribute('data-client-key', clientKey);
            el.onload = resolve;
            el.onerror = reject;

            document.head.appendChild(el);
        });
    },
};

export default midtrans;
